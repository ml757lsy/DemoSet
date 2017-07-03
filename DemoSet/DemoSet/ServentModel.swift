//
//  ServentModel.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/7/3.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit

enum ClassType {
    case saber
    case archer
}
enum CampType {
    case sky
}
/// 从者模型
class ServentModel: FGOModel {

    var serventid:Int  = 0
    var serventLevel:Int = 1
    var attack:Int = 0
    var hp:Int = 0
    var classType:ClassType = .saber
    var campType:CampType = .sky
    
    //其他
    
    var mysticCode:MysticCodeModel = MysticCodeModel()
    
    var buffers:[BufferModel] = []
}
