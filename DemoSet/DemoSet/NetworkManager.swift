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
    public class func request(url:URLConvertible,responseString:@escaping (String)->Void) {
        Alamofire.request(url).responseString { (string) in
            let str = string.result.value!
            responseString(str)
        }
    }
    
    public class func requestModel<T:HandyJSON>(url:URLConvertible,modeltype:T,responseModel:@escaping (_ model:T)->Void) {
        
        NetworkManager.request(url: url) { (string) in
            
            if let mo = JSONDeserializer<T>.deserializeFrom(json: string) {
                responseModel(mo)
            }else{
                responseModel(T())
            }
        }
    }

}

class NetworkModel:HandyJSON {
    
    required init() {}
}

