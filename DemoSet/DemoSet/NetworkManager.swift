//
//  NetworkManager.swift
//  DemoSet
//
//  Created by 李世远 on 2018/5/2.
//  Copyright © 2018年 Far. All rights reserved.
//

import UIKit
import Alamofire
import HandyJSON

/// 网络相关
class NetworkManager: NSObject {
    
    static let manager = NetworkManager()
    
    //class function
    class func request(url:URLConvertible,responseString:@escaping (String)->Void) {
        Alamofire.request(url).responseString { (string) in
            let str = string.result.value!
            responseString(str)
        }
    }
    
    class func request(url:URLConvertible,responseModel:@escaping (String)->Void) {
        
    }

}
