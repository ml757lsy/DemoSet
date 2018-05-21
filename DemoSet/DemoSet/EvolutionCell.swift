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
    
    var state:EvolutionState = EvolutionState()
    
    var nextState:EvolutionState = EvolutionState()

}
