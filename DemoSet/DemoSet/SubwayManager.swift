//
//  SubwayManager.swift
//  DemoSet
//
//  Created by 李世远 on 2018/6/25.
//  Copyright © 2018年 Far. All rights reserved.
//

import UIKit
import HandyJSON

class SubwayManager: NSObject {
    
    static let manager = SubwayManager()

    func loadData()  {
        let path = "/Users/lishiyuan/Desktop/bjdt.txt"
        do {
            let data = try Data.init(contentsOf: URL.init(fileURLWithPath: path))
            let s = String.init(data: data, encoding: .utf8)?.decodeUnicode()
            let json:Dictionary<String,Any> = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! Dictionary
            print(json["content"])
            
//            let result = JSONDeserializer<SubwayResult>.deserializeFrom(json: s)
//            print(result)
        } catch let e {
            print(e)
        }
    }
}

//MARK: - 数据

class SubwayStation: SubwayModel {
    var is_practical:Int = 1
    var name = ""
    var uid = ""
    var x = ""
    var y = ""
}

class SubwayLine: SubwayModel {
    var line_name = ""
    var line_uid = ""
    var pair_line_uid = ""
    var stops:[SubwayStation] = []
}

class SubwayContent: SubwayModel {
    var content:[SubwayLine] = []
    var result:SubwayResult = SubwayResult()
}
class SubwayResult: SubwayModel {
    var ccode:Int = 0
    var qt = ""
}

class SubwayModel:HandyJSON {
    
    required init() {}
}
