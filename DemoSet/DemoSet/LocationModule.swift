//
//  LocationModule.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/9/14.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit
import CoreLocation

enum LocationPreset {
    case home
    case company
}

class LocationModule: NSObject {
    
    
    /// 位置区域
    ///
    /// - Parameters:
    ///   - latitude: 经度
    ///   - longitude: 未读
    ///   - radius: 范围 米
    /// - Returns: region
    class func region(latitude:Double,longitude:Double,radius:Double,identifier:String = "") -> CLRegion{
        
        let locationcoordinate = CLLocationCoordinate2D.init(latitude: CLLocationDegrees.init(latitude), longitude: CLLocationDegrees.init(longitude))
        
        let region = CLCircularRegion.init(center: locationcoordinate, radius: CLLocationDistance.init(50), identifier: identifier)
        
        return region
    }
    
    /// 加载预设地点
    ///
    /// - Parameter preset: 预设
    /// - Returns: region
    class func region(with preset:LocationPreset) -> CLRegion{
        switch preset {
        case .home:
            return region(latitude: 116.360544, longitude: 40.053079, radius: 50)
        case .company:
            return region(latitude: 116.45673, longitude: 40.041266, radius: 50)
        default:
            return region(latitude: 116.360544, longitude: 40.053079, radius: 50)
        }
    }

}
