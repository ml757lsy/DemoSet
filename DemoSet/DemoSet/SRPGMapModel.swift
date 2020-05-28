//
//  SRPGMapModel.swift
//  DemoSet
//
//  Created by 李世远 on 2019/3/27.
//  Copyright © 2019 Far. All rights reserved.
//

import UIKit

enum BlockType {
    case Land
    case Meadow//草
    case Forest//
    case River
    case Mountain
    case Sea
    case Cliff//悬崖
}

/// 地图模型
class SRPGMapModel: NSObject {
    
    private var list:[[BlockType]] = []
    
    var width:Int = 0
    var heigh:Int = 0
    
    var mapView:UIView = UIView()
    
    class func initMap(width:Int, heigh:Int) -> SRPGMapModel {
        let map = SRPGMapModel()
        map.width = width
        map.heigh = heigh
        for _ in 0..<heigh {
            var wline:[BlockType] = []
            for _ in 0..<width {
                wline.append(.Land)
            }
            map.list.append(wline)
        }
        return map
    }
    
    func mapList() -> [[BlockType]] {
        return self.list
    }
    
    func drawMap() {
        
    }

}

class RolePosition: NSObject {
    var x:Int = 0
    var y:Int = 0
    
    class func birthPosition() -> RolePosition {
        let p = RolePosition.initWith(x: -1, y: -1)
        return p
    }
    
    class func initWith(x:Int, y:Int) -> RolePosition {
        let p = RolePosition.init()
        p.x = x
        p.y = y
        return p
    }
}
