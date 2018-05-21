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
        
        for _ in 0..<cellnum {
            let cell = EvolutionCell()
            cells.append(cell)
        }
        
        for w in 0..<groundwidth {
            for h in 0..<height {
                let ground = EvolutionGround()
                grounds.append(ground)
            }
        }
        print("World Created!")
        
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
            if cell.state.reaction > 0 {
                //continue
                cell.continueState()
            }
        }
    }
    
    /// next -> now
    func updateCells() {
        print("Update")
        for cell in cells {
            cell.oldState = cell.state
            cell.state = cell.nextState
        }
    }
    
}
