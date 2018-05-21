//
//  EvolutionAttribute.swift
//  DemoSet
//
//  Created by lishiyuan on 2018/5/21.
//  Copyright © 2018年 Far. All rights reserved.
//

import UIKit

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

}
