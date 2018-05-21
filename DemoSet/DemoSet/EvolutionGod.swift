//
//  EvolutionGod.swift
//  DemoSet
//
//  Created by lishiyuan on 2018/5/21.
//  Copyright © 2018年 Far. All rights reserved.
//

import UIKit

/// I'm THE GOD!
class EvolutionGod: NSObject {

    static let god = EvolutionGod.init()
    
    var grounds:[EvolutionGround] = []
    var cells:[EvolutionCell] = []
    
    
    func creatWorld(with cellnum:Int,ground width:Int,and height:Int, with size:CGFloat) {
        grounds.removeAll()
        cells.removeAll()
        
    }
    
    func update(cells:[EvolutionCell]) {
        for cell in cells {
            //
        }
    }
    
}
