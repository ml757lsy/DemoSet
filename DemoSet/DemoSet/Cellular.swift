//
//  Cellular.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/6/9.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit

enum CellularType:Int {
    case null = 0
    case ground = 1
    case cell = 2
    case newcell = 3
    
}

/// 元胞状态
///
/// - die: 死亡
/// - dying: 濒死
/// - weak: 虚弱
/// - live: 生存
/// - satisfy: 满足
/// - cosy: 舒适
enum CellLiveState:Int {
    case die = 0//死亡
    case dying = 1
    case weak = 2
    case live = 3//基本线
    case satisfy = 4
    case cosy = 5//无欲无求
}

struct Cellular {
    /// 元胞类型
    var type:CellularType = .null
    
    /// 范围
    var range:Int = 1
    
    /// 最新生存需求
    var minSuport:Int = 2
    
    /// 最大生存限制
    var maxSuport:Int = 3
    
    //其他信息
    var liveState:CellLiveState = .live
    
    var nutrient:Int = 3
}
