//
//  SocketManager.swift
//  Socket_demo
//
//  Created by 易联互动 on 17/6/23.
//  Copyright © 2017年 易联互动. All rights reserved.
//

import UIKit

class SocketManager: NSObject, GCDAsyncSocketDelegate {
    
    var clientSocket: GCDAsyncSocket!
    var host = "host"
    var port: UInt16 = 0000
    var timer: Timer!
    
    var isBindSuc = false
    
    
    
    static var sharedInstance: SocketManager {
        struct Static {
            static let instance = SocketManager()
        }
        return Static.instance
        
    }
    
    override init() {
        super.init()
        clientSocket = GCDAsyncSocket.init(delegate: self, delegateQueue: DispatchQueue.main)
    }
    
    //MARK: - GCDAsyncSocketDelegate
    
    func connectClient() {
        if clientSocket.isConnected {
            print("已连接")
            bindClient()
            return
        }else {
            do {
                try clientSocket.connect(toHost: host, onPort: port)
            }catch {
                print("error")
            }
        }

    }
    
    func disConnectClient() {
        if clientSocket.isConnected {
            clientSocket.disconnect()
        }
    }
    
    func bindClient() {
        var link: [UInt8] = [0x00, 0x00, 0x00, 0x00]
        let usrData = UserInfo().userPhone.data(using: .utf8)
        for i in usrData! {
            link.append(i)
        }
        let data = NSData(bytes: link, length: link.count)
        clientSocket.write(data as Data, withTimeout: -1, tag: 1002)
        clientSocket.readData(withTimeout: -1, tag: 2000)
    }
    
    func heartRebeating() {
        let link: [UInt8] = [0x00, 0x00, 0x00, 0x00]
        let data = NSData(bytes: link, length: 4)
        clientSocket.write(data as Data, withTimeout: -1, tag: 1002)
    }
    
    func socket(_ sock: GCDAsyncSocket, didConnectToHost host: String, port: UInt16) {
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(self.heartRebeating), userInfo: nil, repeats: true)
        }
        clientSocket.readData(withTimeout: -1, tag: 0)
    }
    
    func socketDidDisconnect(_ sock: GCDAsyncSocket, withError err: Error?) {
        print("与服务器断开连接")
    }
    
    func socket(_ sock: GCDAsyncSocket, didRead data: Data, withTag tag: Int) {
        var dataStr = ""
        print("data = \(data) last = \(data.last))")
        //        for i in data {
        //            print(i)
        //        }
        switch data[3] {
        case 0x00:
            break
        case 0x01:
            if data[4] == 0 {
                isBindSuc = true
            }else {
                isBindSuc = false
                bindClient()
            }
            break
        case 0x02:
            dataStr = String.init(data: data, encoding: .utf8) ?? ""
            let strArr = dataStr.components(separatedBy: ",")
            UserDefaults.standard.setValue(strArr.last, forKey: "PostData")
            
            //本地通知
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notice"), object: nil)
            //通知弹屏
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notification"), object: nil)
            break
        default:
            break
        }
        clientSocket.readData(withTimeout: -1, tag: 0)
    }
    
    func socket(_ sock: GCDAsyncSocket, didWriteDataWithTag tag: Int) {
        clientSocket.readData(withTimeout: -1, tag: 1001)
    }
}

struct UserInfo {
    var userPhone: String!
    var callPhone: String!
    var isOk = false
    
    init() {
        let userDef = UserDefaults.standard.value(forKey: "LoginState")
        let postData = UserDefaults.standard.value(forKey: "PostData")
        if userDef != nil {
            let json = JSON(parseJSON: userDef as! String)
            userPhone = json["userPhone"].stringValue
            if postData != nil {
                callPhone = postData as! String
            }
            isOk = json["isOk"].boolValue
        } else {
            userPhone = "未知"
            callPhone = "未知"
            isOk = false
        }
    }
}
