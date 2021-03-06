//
//  EvolutionAttribute.swift
//  DemoSet
//
//  Created by lishiyuan on 2018/5/21.
//  Copyright © 2018年 Far. All rights reserved.
//

import UIKit


/// 级别
///
/// - food: 纯粹
/// - provider: 最低价
/// - normal: 正常
/// - consume: 消费者
/// - hunter: 会猎杀
enum EvolutionType:Int {
    case food
    case provider
    case normal
    case consume
    case hunter
}

class EvolutionAttribute: NSObject {
    
    var type:Int = 0
    var typeReproductive:Int = 5
    
    
    /// reaction duration
    var reaction:CGFloat = 0.2
    var reactionMin:CGFloat = 0.1
    var reactionMax:CGFloat = 0.5
    var reactionMutation:CGFloat = 0.01
    
    /// speed
    var speed:CGFloat = 1
    var speedMin:CGFloat = 0
    var speedMax:CGFloat = 10
    var speedMutation:CGFloat = 0.2
    
    /// view
    var view:CGFloat = 1
    var viewMin:CGFloat = 0
    var viewMax:CGFloat = 10
    var viewMutation:CGFloat = 0.2
    var viewFrontAmend:CGFloat = 1.3
    var viewBackAmend:CGFloat = 0.3
    var viewSideAmned:CGFloat = 0.8
    
    /// size
    var size:CGFloat = 0.01
    var sizeMin:CGFloat = 0.001
    var sizeMax:CGFloat = 100
    var sizeMutation:CGFloat = 0.1
    
    // energy
    var energy:CGFloat = 10         //size
    var energyProduce:CGFloat = 0.1
    var energyCost:CGFloat = 0.1
    var energyMin:CGFloat = 1
    var energyMax:CGFloat = 100
    
    /// 危险程度
    var danger:CGFloat = 10
    var dangerScope:CGFloat = 10//适应的范围
    var dangerFit:CGFloat = 10//适应的
    
    var attack:CGFloat = 1
    var attackType:Int = 0
    var foodType:EvolutionType = .normal
    var eatType:EvolutionType = .provider

}
