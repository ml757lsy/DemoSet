//
//  SRPGRoleModel.swift
//  DemoSet
//
//  Created by lishiyuan on 2018/1/4.
//  Copyright © 2018年 Far. All rights reserved.
//

import UIKit

enum RoleType {
    case footman
    case rider
    case airunit
}

enum ArmorType {
    case Light
    case Medium
    case Heavy
}

enum AttackType {
    case Puncture
    case Normal
    case Magic
}

enum AttackForm {
    case Cross
    case Round
    case Stellate
}

class SRPGRoleModel: NSObject {
    
    var type:RoleType = .footman
    var name:String = ""
    var id:Int = 0
    
    //info
    var hp:Int = 0
    var mp:Int = 0
    var move:Int = 0
    var maxRange:Int = 0//
    var minRange:Int = 0//
    
    var power:Int = 0
    var agient:Int = 0
    var iten:Int = 0
    
    var exp:Int = 0
    var level:Int = 0
    
    //
    var attackForm:AttackForm = .Cross
    
    //map
    var location:RolePosition = RolePosition.birthPosition()
    
    /// 返回区域 相对
    func getAttackArea() -> Array<RolePosition> {
        var pos = Array<RolePosition>.init()
        switch self.attackForm {
        case .Cross:
            var pc = Array<RolePosition>.init()
            for i in self.minRange..<self.maxRange {
                let pl = RolePosition.initWith(x: -i, y: 0)
                let pr = RolePosition.initWith(x: i, y: 0)
                let pt = RolePosition.initWith(x: 0, y: -i)
                let pb = RolePosition.initWith(x: 0, y: i)
                pc.append(pl)
                pc.append(pr)
                pc.append(pt)
                pc.append(pb)
            }
            pos.append(contentsOf: pc)
            break
        case .Round:
            var pr = Array<RolePosition>.init()
            for i in self.minRange...self.maxRange {
                for j in self.minRange...self.minRange-self.minRange {
                    let p1 = RolePosition.initWith(x:  -i, y: j)
                    let p2 = RolePosition.initWith(x:  i, y: j)
                    let p3 = RolePosition.initWith(x:  -i, y: -j)
                    let p4 = RolePosition.initWith(x:  i, y: -j)
                    pr.append(p1)
                    pr.append(p2)
                    pr.append(p3)
                    pr.append(p4)
                }
            }
            pos.append(contentsOf: pr)
            break
        case .Stellate:
            break
        default:
            break
        }
        
        return pos
    }
    
    /// 返回移动区域
    func getMoveArea() -> Array<RolePosition>{
        return Array()
    }
    
    class func newFootMan() {
        
    }
    
    class func newRider() {
        
    }
    
    class func newAirUnit() {
        
    }
}
