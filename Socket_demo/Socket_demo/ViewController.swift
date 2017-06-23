//
//  ViewController.swift
//  Socket_demo
//
//  Created by 易联互动 on 17/6/6.
//  Copyright © 2017年 易联互动. All rights reserved.
//

import UIKit
import JavaScriptCore

class ViewController: UIViewController, UIWebViewDelegate, GCDAsyncSocketDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    var urlStr = "url"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        webView.delegate = self
        webViewLoadRequest()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webViewLoadRequest() {
        let user = UserInfo()
        if user.isOk {
            webView.loadRequest(URLRequest(url: URL(string: urlStr + user.callPhone!)!))
        }else {
            webView.loadRequest(URLRequest(url: URL(string: urlStr)!))
        }
    }
    
    //MARK: - WebViewDelegate
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        let context = webView.value(forKeyPath: "documentView.webView.mainFrame.javaScriptContext") as? JSContext
        print(context as Any)
        let model = JSContextModel()
        model.viewController = self
        model.jsContext = context
        let jsContextTemp = context
        
        // 这一步是将OCModel这个模型注入到JS中，在JS就可以通过OCModel调用我们公暴露的方法了。
        jsContextTemp?.setObject(model, forKeyedSubscript: "model" as (NSCopying & NSObjectProtocol)!)
        jsContextTemp?.exceptionHandler = {
            (context, exception) in
            print("exception @", exception as Any)
        }
        
        if UserInfo().isOk {
            SocketManager.sharedInstance.connectClient()
        }
    }
    

}

