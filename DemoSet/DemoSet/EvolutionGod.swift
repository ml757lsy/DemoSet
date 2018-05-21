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
    
    var timer:Timer = Timer()
    
    
    func creatWorldwith(cellnum:Int, groundwidth:Int, height:Int, size:CGFloat) {
        grounds.removeAll()
        cells.removeAll()
        
    }
    
    func startEvolution() {
        if timer.isValid {
            timer.fireDate = Date.init()
        }else{
            timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(nextStep), userInfo: nil, repeats: true)
        }
    }
    
    func stopEvolution() {
        timer.invalidate()
    }
    
    /// get next
    func nextStep() {
        updateCells()
        
        for cell in cells {
            //
        }
    }
    
    /// next -> now
    func updateCells() {
        
    }
    
}
