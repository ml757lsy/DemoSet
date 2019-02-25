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
    
    var grounds:[[EvolutionGround]] = [[]]
    var cells:[EvolutionCell] = []
    
    var timer:Timer = Timer()
    
    
    func creatWorldwith(cellnum:Int, groundwidth:Int, height:Int, size:CGFloat) {
        grounds.removeAll()
        cells.removeAll()
        
        for _ in 0..<cellnum {
            let cell = EvolutionCell()
            cells.append(cell)
        }
        
        for h in 0..<height {
            var line:[EvolutionGround] = []
            for w in 0..<groundwidth {
                let ground = EvolutionGround()
                ground.position = CGPoint.init(x: w, y: h)
                ground.size = size
                line.append(ground)
            }
            grounds.append(line)
        }
        //random
        for cell in cells {
            
            cell.state.position = CGPoint.init(x: 1, y: 3)
            cell.ground = grounds[2][1]
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
    @objc func nextStep() {
        updateCells()
        
        for cell in cells {
            //
            if cell.state.reaction > 0 {
                //continue
                cell.continueState()
            }else{
                //检查下一步
                //grounds
                var checkGds:[EvolutionGround] = []
                let g = cell.ground
                let p = cell.state.position
                let s = cell.attribute.view
                
                if p.x < s {//<
                    if g.position.x > 0{
                        let l = Int(g.position.y)
                        let w = Int(g.position.x - 1)
                        let g = grounds[l][w]
                        checkGds.append(g)
                    }
                }
                if g.size - p.x < s {//>
                    if Int(g.position.x) < grounds[0].count-1{
                        let l = Int(g.position.y)
                        let w = Int(g.position.x + 1)
                        let g = grounds[l][w]
                        checkGds.append(g)
                    }
                }
                if p.y < s {//^
                    if Int(g.position.y) > 0{
                        let l = Int(g.position.y - 1)
                        let w = Int(g.position.x)
                        let g = grounds[l][w]
                        checkGds.append(g)
                    }
                }
                if g.size - p.y < s {//|
                    if Int(g.position.y) < grounds.count-1{
                        let l = Int(g.position.y + 1)
                        let w = Int(g.position.x)
                        let g = grounds[l][w]
                        checkGds.append(g)
                    }
                }
                if p.x*p.x+p.y*p.y < s*s {//<^
                    if Int(g.position.y) > 0 && Int(g.position.x) > 0{
                        let l = Int(g.position.y - 1)
                        let w = Int(g.position.x - 1)
                        let g = grounds[l][w]
                        checkGds.append(g)
                    }
                }
                if p.x*p.x+(g.size - p.y)*(g.size - p.y) < s*s {//<|
                    if Int(g.position.y) < grounds.count-1 && Int(g.position.x) > 0{
                        let l = Int(g.position.y + 1)
                        let w = Int(g.position.x - 1)
                        let g = grounds[l][w]
                        checkGds.append(g)
                    }
                }
                if (g.size - p.x)*(g.size - p.x)+p.y*p.y < s*s {//>^
                    if Int(g.position.y) > 0 && Int(g.position.x) < grounds[0].count-1{
                        let l = Int(g.position.y - 1)
                        let w = Int(g.position.x + 1)
                        let g = grounds[l][w]
                        checkGds.append(g)
                    }
                }
                if (g.size - p.x)*(g.size - p.x)+(g.size - p.y)*(g.size - p.y) < s*s {//>|
                    if Int(g.position.y) < grounds.count-1 && Int(g.position.x) < grounds[0].count-1{
                        let l = Int(g.position.y + 1)
                        let w = Int(g.position.x + 1)
                        let g = grounds[l][w]
                        checkGds.append(g)
                    }
                }
                //enemy
                //food
                var enemys:[EvolutionCell] = []
                var foods:[EvolutionCell] = []
                for g in checkGds {
                    for c in g.cells {
                        if c.attribute.type == cell.attribute.type {//一般来说同类不管
                            continue
                        }
                        if c.attribute.danger > cell.attribute.dangerFit + cell.attribute.dangerScope {
                            enemys.append(c)
                        }else if c.attribute.foodType.rawValue <= cell.attribute.eatType.rawValue {
                            foods.append(c)
                        }
                    }
                }
                //ai
                for enemy in enemys {
                    //
                    print(enemy.attribute.danger)
                }
                //food pai
                foods.sort { (c1, c2) -> Bool in
                    return c1.attribute.danger > c2.attribute.danger
                }
                for food in foods {
                    //
                    print(food.attribute.danger)
                }
                //other
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
