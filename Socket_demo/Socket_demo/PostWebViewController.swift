//
//  PostWebViewController.swift
//  Socket_demo
//
//  Created by 易联互动 on 17/6/23.
//  Copyright © 2017年 易联互动. All rights reserved.
//

import UIKit
import JavaScriptCore

class PostWebViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        webViewLoadRequest()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webViewLoadRequest() {
        let user = UserInfo()
        let URLStr = "url"
        webView.loadRequest(URLRequest(url: URL(string: URLStr)!))
    }
    
    //MARK: - WebViewDelegate
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        let context = webView.value(forKeyPath: "documentView.webView.mainFrame.javaScriptContext") as? JSContext
        print(context as Any)
        let model = JSContextModel()
        model.postController = self
        model.jsContext = context
        let jsContextTemp = context
        
        // 这一步是将OCModel这个模型注入到JS中，在JS就可以通过OCModel调用我们公暴露的方法了。
        jsContextTemp?.setObject(model, forKeyedSubscript: "model" as (NSCopying & NSObjectProtocol)!)
        jsContextTemp?.exceptionHandler = {
            (context, exception) in
            print("exception @", exception as Any)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
