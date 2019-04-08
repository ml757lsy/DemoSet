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
    
    var list:[BlockType] = []
    
    class func initMap() -> SRPGMapModel {
        let map = SRPGMapModel()
        return map
    }

}
