//
//  EvolutionCell.swift
//  DemoSet
//
//  Created by lishiyuan on 2018/5/21.
//  Copyright © 2018年 Far. All rights reserved.
//

import UIKit

class EvolutionCell: NSObject {
    
    unowned var ground:EvolutionGround = EvolutionGround()
    
    /// attribute
    var attribute:EvolutionAttribute = EvolutionAttribute()
    
    /// 状态
    var state:EvolutionState = EvolutionState()
    var nextState:EvolutionState = EvolutionState()
    var oldState:EvolutionState = EvolutionState()
    
    
    /// jix
    func continueState() {
        
        var propNum:UInt32 = 0
        let properties = class_copyPropertyList(EvolutionState.self, &propNum)
        var text:String = ""
        
        for index in 0..<numericCast(propNum) {
            let p:objc_property_t = properties![index]
            
            let name = String.init(utf8String: property_getName(p))
            let attribute = String.init(utf8String: property_getAttributes(p)!)

            text.append("\np_name:\(name)")
            text.append("\np_attribute:\(String.init(utf8String: property_getAttributes(p)!))")
            
            let oldvalue = oldState.value(forKey: name!)
            let newvalue = state.value(forKey: name!)
            
            var type:String = (attribute?.components(separatedBy: ",").first!)!
            type = type.substring(from: String.Index.init(encodedOffset: 1))
            //计算属性的才计算
            if "idfl".contains(type) {//int double float long
                let change = (newvalue as! CGFloat) - (oldvalue as! CGFloat)
                print(change)
            }
            
        }
        print(text)
        
        nextState.reaction -= 0.05//减去时间粒度  精度问题
        
    }

}
