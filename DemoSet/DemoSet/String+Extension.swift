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
    
}
