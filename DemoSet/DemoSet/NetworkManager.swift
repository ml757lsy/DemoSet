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
    
    //function
    func get(url:URLConvertible,responseString:@escaping (String)->Void) {
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseString { (string) in
            let str = string.result.value
            responseString(str ?? "")
        }
    }
    
    func post(url:URLConvertible,parameters:Parameters?,resonseString:@escaping (String)->Void) {
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseString { (string) in
            let str = string.result.value
            resonseString(str ?? "")
        }
    }
    
    func upload(url:URLConvertible, file:URL, progressHandler:@escaping BaseBlockCGFloat) {
        Alamofire.upload(file, to: url).uploadProgress { (progress) in
            //
//            progressHandler(progress)
        }
    }
    
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
    
    public class func requestModel<T:HandyJSON>(url:URLConvertible,
                                                method:HTTPMethod = HTTPMethod.get,
                                                parameters:Parameters? = nil,
                                                encodiong:ParameterEncoding = URLEncoding.default,
                                                headers: HTTPHeaders? = nil,
                                                modelType:T,
                                                success:@escaping (_ model:T)->Void,
                                                fail:@escaping(NSError)->Void) {
        
        Alamofire.request(url, method: method, parameters: parameters, encoding: encodiong, headers: headers).responseString { (string) in
            
            var error = NSError.init(domain: "", code: 0, userInfo: nil)
            
            if string.result.isFailure {
                fail(error)
            }
            
        }
        
    }

}

class NetworkModel:HandyJSON {
    
    required init() {}
}

