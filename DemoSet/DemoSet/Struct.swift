//
//  Struct.swift
//  DemoSet
//
//  Created by 李世远 on 2019/3/27.
//  Copyright © 2019 Far. All rights reserved.
//

import UIKit

enum StructType {
    case Hero
    case Weapon
    case Trap
}

/// 构造图
class Struct: NSObject {
    var type:StructType = .Hero
    var level:NSInteger = 1
    var name:String = ""
    var des:String = ""
    var icon:String = ""
}

class WeaponStruct: Struct {
    override init() {
        super.init()
        type = .Weapon
    }
    var other:String = ""//其他资质 比如橙
    var attack:CGFloat = 0
    var exp:CGFloat = 0
    var star:NSInteger = 0;//阶
}
