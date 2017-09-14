//
//  NotificationModule.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/9/14.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit
import UserNotifications
import CoreLocation

class NotificationModule: NSObject {
    
    
    class func registNotification() {
        let ver = UIDevice.current.systemVersion
        let result = ver.compare("10.0.0")
        
        if result == .orderedAscending {
            let setting = UIUserNotificationSettings.init(types: .init(rawValue: 2), categories: nil)
            UIApplication.shared.registerUserNotificationSettings(setting)
        }else{
            if #available(iOS 10.0, *) {
                let center = UNUserNotificationCenter.current()
                center.requestAuthorization(options: .init(rawValue: 2), completionHandler: { (succ, error) in
                    //
                })
            } else {
                
            }
            
        }
    }
    
    class func addLocalNotification() {
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            
            //content
            var content = UNMutableNotificationContent()
            content.title = ""
            content.subtitle = ""
            content.body = ""
            
            //trigger
            //通知的触发器
            //1.计时器类型的，可单次可循环
            let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 10, repeats: true)
            
            var datecomponent = DateComponents.init()
            //每周1 8点
            datecomponent.weekday = 2
            datecomponent.hour = 8
            
            //按具体日期
            datecomponent.year = 2017
            datecomponent.month = 11
            datecomponent.day = 10
            
            //2.日历类型，随制定日期格式触发，可循环
            let trigger2 = UNCalendarNotificationTrigger.init(dateMatching: datecomponent, repeats: true)
            
            //3.位置触发类型，进入到某个位置可以触发通知
            let region = LocationModule.region(latitude: 111, longitude: 111, radius: 50)
            
            let trigger3 = UNLocationNotificationTrigger.init(region: region, repeats: true)
            
            //request
            let identifier = "testnotification"
            let request = UNNotificationRequest.init(identifier: identifier, content: content, trigger: trigger)
            center.add(request, withCompletionHandler: { (error) in
                //
            })
        } else {
            // Fallback on earlier versions
        }
    }

}
