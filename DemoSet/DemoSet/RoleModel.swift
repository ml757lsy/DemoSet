//
//  RoleModel.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/11/28.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit

enum RoleType {
    case footman
    case rider
    case airunit
}

class RoleModel: NSObject {

    var type:RoleType = .footman
    var name:String = ""
    var id:Int = 0
    
    //info
    var hp:Int = 0
    var mp:Int = 0
    var move:Int = 0
    var range:Int = 0
    
    var power:Int = 0
    var agient:Int = 0
    var iten:Int = 0
    
    var exp:Int = 0
    var level:Int = 0
    
    
    
    class func newFootMan() {
        
    }
    
    class func newRider() {
        
    }
    
    class func newAirUnit() {
        
    }
}
