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
    
    
    /// 注册通知
    class func registNotification() {
        let ver = UIDevice.current.systemVersion
        let result = ver.compare("10.0.0")
        
        if result == .orderedAscending {
            let setting = UIUserNotificationSettings.init(types: [.badge,.alert,.sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(setting)
        }else{
            if #available(iOS 10.0, *) {
                let center = UNUserNotificationCenter.current()
                center.requestAuthorization(options: [.badge,.alert,.sound], completionHandler: { (succ, error) in
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
    
    class func addHomeNotification() {
        if #available(iOS 10.0, *) {
            let content = UNMutableNotificationContent()
            content.title = "Yo~"
            content.subtitle = "提示"
            content.body = "已经在家附近了"
            
            let trigger = UNLocationNotificationTrigger.init(region: LocationModule.region(with: .home), repeats: true)
            
            let request = UNNotificationRequest.init(identifier: "home", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request, withCompletionHandler: { (error) in
                print(error)
            })
        } else {
            // Fallback on earlier versions
        }
    }

    
    class func addNotification(preset:LocationPreset){
        if #available(iOS 10.0, *) {
            let content = UNMutableNotificationContent()
            content.title = "Yo~"
            content.subtitle = "提示"
            content.body = "已经在家附近了"
            switch preset {
            case .home:
                content.body = "已经在家附近了~"
                break
            case .company:
                content.body = "到公司了~"
                break
            default:
                break
            }
            
            let trigger = UNLocationNotificationTrigger.init(region: LocationModule.region(with: preset), repeats: true)
            
            let request = UNNotificationRequest.init(identifier: "home", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request, withCompletionHandler: { (error) in
                print(error)
            })
        } else {
            // Fallback on earlier versions
        }
    }

}
