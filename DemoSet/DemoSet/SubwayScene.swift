//
//  SubwayScene.swift
//  MyApp
//
//  Created by LiShiyuan on 2017/4/6.
//  Copyright © 2017年 com.ml.app. All rights reserved.
//

import UIKit
import SpriteKit

class SubwayScene: SKScene {
    
    
    func initSubwayData(with lines:[Line], and stations:[Station]){
        var stationSet = NSMutableSet()
        
        let x = self.frame.size.width/2
        let y = self.frame.size.height/2
        
        for line in lines {
            for stationid in line.stations {
                let station = SubwayData.defaultSubwayData.getStation(with: stationid)
                
                if stationSet.contains(stationid) {
                    //变色咯
                    let node = childNode(withName: "\(stationid)") as! SKShapeNode
                    node.strokeColor = UIColor.red
                    continue
                }
                stationSet.add(stationid)
                let stationsp = SKShapeNode.init(rectOf: CGSize.init(width: 12, height: 12), cornerRadius: 6)
                stationsp.position = CGPoint.init(x: x + station.position.x, y: y + station.position.y)
                stationsp.fillColor = UIColor.blue
                stationsp.strokeColor = UIColor.cyan
                stationsp.name = "\(stationid)"
                addChild(stationsp)
            }
        }
    }

}
