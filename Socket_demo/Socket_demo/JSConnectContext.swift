//
//  JSConnectContext.swift
//  JSExtractContext
//
//  Created by 易联互动 on 17/5/8.
//  Copyright © 2017年 易联互动. All rights reserved.
//

import UIKit
import JavaScriptCore

@objc protocol JSContextDelegate: JSExport {
    
    //关闭弹屏
    func closePresentView()
    //记录登录状态、用户名
    func setLoginState(json: String)
    
}


@objc class JSContextModel: NSObject, JSContextDelegate {
    
    weak var jsContext: JSContext?
    weak var postController: PostWebViewController!
    weak var viewController: ViewController!
    
    //记录登录状态、用户名
    internal func setLoginState(json: String) {
        let usrDef = UserDefaults.standard
        usrDef.setValue(json, forKey: "LoginState")
        usrDef.synchronize()
    }
    
    //关闭弹屏
    func closePresentView() {
        DispatchQueue.main.async {
            UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
        }
    }
}
