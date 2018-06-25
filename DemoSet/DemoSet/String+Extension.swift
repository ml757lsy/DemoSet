//
//  String+Extension.swift
//  DemoSet
//
//  Created by lishiyuan on 2018/5/22.
//  Copyright © 2018年 Far. All rights reserved.
//

import UIKit

extension  String {

    func containsNumber() -> Bool {
        for c in self {
            if c > "0"&&c < "9" {
                return true
            }
        }
        return false
    }
    
    func containsLowercased() ->Bool {
        for c in self {
            if c > "a"&&c < "z" {
                return true
            }
        }
        return false
    }
    
    func containsUppercased() ->Bool {
        for c in self {
            if c > "A"&&c < "Z" {
                return true
            }
        }
        return false
    }
    
    func containsSigns(sign:String) -> Bool {
        var result = false
        for c in sign {
            result = self.contains(c) || result
        }
        return result
    }
    
    /// 解Unicode编码
    ///
    /// - Returns: uft8编码
    func decodeUnicode() -> String {
        var temp = self
        temp = temp.replacingOccurrences(of: "\\u", with: "\\U")
        temp = temp.replacingOccurrences(of: "\"", with: "\\\"")
        temp = "\""+temp+"\""
        let data = temp.data(using: String.Encoding.utf8)
        var result = ""
        
        do {
            result = try PropertyListSerialization.propertyList(from: data!, options: PropertyListSerialization.ReadOptions.init(rawValue: 0), format: nil) as! String
            
        } catch let error {
            print(error )
        }
        return result.replacingOccurrences(of: "\\r\\n", with: "\n")
    }
    
}
