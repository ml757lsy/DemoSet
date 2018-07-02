//
//  AppDelegate.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/6/9.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let navigation = UINavigationController()
        navigation.tabBarItem = UITabBarItem.init(title: "111", image: nil, tag: 1)
        navigation.viewControllers.append(ViewController())
        
        let appstore = AppStoreViewController()
        appstore.tabBarItem = UITabBarItem.init(title: "Store", image: nil, tag: 2)
                
        let tab = BaseTabBarViewController()
        tab.viewControllers = [navigation,appstore]
        
        window?.rootViewController = tab
        
        //slide
        let main = MainViewController()
        main.baseinit()
        let left = LeftViewController()
        let nvc = UINavigationController.init(rootViewController: main)
        
        let  slide = SlideMenuViewController.init(leftViewController: left, mainViewController: nvc)
//        window?.rootViewController = slide
        
        NotificationModule.manager.registNotification()
        NotificationModule.manager.addHomeNotification()
        UNUserNotificationCenter.current().delegate = self
        
        // Override point for customization after application launch.
        return true
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

    //MARK: - notification
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print(deviceToken)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error)
    }

    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        //
    }
    
    
    //MARK: - delegate
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        //
        print(notification.date)
        print(notification.request.identifier)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        //
    }
    
    

}

/// 自定义打印
///
/// - Parameters:
///   - message: 信息
///   - file: 文件
///   - line: 行号
///   - function: 功能
public func Print<T>(_ message:T, file:String = #file, line:Int = #line, function:String = #function) {
    #if DEBUG
        let filename = (file as NSString).lastPathComponent
        print("#\(filename)-\(line):\(message)")
    #endif
}

