//
//  AppDelegate.swift
//  xPower
//
//  Created by Mikita Gandhi on 7/17/17.
//  Copyright © 2017 Software Merchant. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var isRequestAppear=false


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        /* Start Register User Notification Setting */
        let application = UIApplication.shared
        if #available(iOS 10.0, *)
        {
            let center=UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.badge,.alert,.sound], completionHandler: { (granted, error) in })
        }
        else
        {
            application.registerUserNotificationSettings(UIUserNotificationSettings(types:[.alert,.badge,.sound],categories:nil))
        }
        application.registerForRemoteNotifications()
        
        /* End Register User Notification Setting */
        return true
    }
    
    class func getDelegate() -> AppDelegate
    {
        return UIApplication.shared.delegate as! AppDelegate
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

}

