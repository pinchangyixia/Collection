//
//  AppDelegate.swift
//  Socket_demo
//
//  Created by 易联互动 on 17/6/6.
//  Copyright © 2017年 易联互动. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.presentAction), name: NSNotification.Name(rawValue: "notification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.scheduleNotification), name: NSNotification.Name(rawValue: "notice"), object: nil)
        //通知
        let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound],
                                                  categories: nil)
        application.registerUserNotificationSettings(settings)
        application.registerForRemoteNotifications()
        return true
    }
    
    func scheduleNotification() {
        let localNoti = UILocalNotification()
        localNoti.timeZone = NSTimeZone.default
        localNoti.alertBody = "通知消息"
        localNoti.alertTitle = "您有一条新消息"
        localNoti.soundName = UILocalNotificationDefaultSoundName
        UIApplication.shared.presentLocalNotificationNow(localNoti)
    }
    
    func presentAction() {
        let current = UIApplication.shared.keyWindow?.rootViewController
        if (current?.isKind(of: PostWebViewController.self))! == false {
            DispatchQueue.main.async {
                let postVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PostWebView")
                self.window?.rootViewController?.present(postVC, animated: true, completion: nil)
            }
        } else {
            print("弹屏已存在")
            current?.dismiss(animated: true, completion: nil)
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        
    }

}

