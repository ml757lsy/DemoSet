//
//  MysticCodeModel.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/7/3.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit

/// 礼装模型
class MysticCodeModel: FGOModel {

    var mysticcodeId:Int = 0
    var name:String = ""
    var icon:String = ""
    var info:String = ""
    
    var attack:Int{
        get{
            return baseAttack + attackGrow * level
        }
    }
    
    var HP:Int{
        get{
            return baseHP + HPGrow * level
        }
    }
    var level:Int = 0
    
    var baseAttack:Int = 0
    var attackGrow:Int = 0
    
    var baseHP:Int = 0
    var HPGrow:Int = 0
    
    var buffers:[BufferModel] = []
}
