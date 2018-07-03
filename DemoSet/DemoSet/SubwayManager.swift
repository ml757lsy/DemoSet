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
    
    var contentData:[SubwayLine] = []
    
    func loadData()  {
        let path = "/Users/lishiyuan/Desktop/bjdt.txt"
        do {
            let data = try Data.init(contentsOf: URL.init(fileURLWithPath: path))
            let s = String.init(data: data, encoding: .utf8)?.decodeUnicode()
            let json:Dictionary<String,Any> = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! Dictionary
            let contests = json["content"] as! [[String:Any]]
            for content in contests {
                let line = SubwayLine()
                line.line_name = content["line_name"] as! String
                line.line_uid = content["line_uid"] as! String
                line.pair_line_uid = content["pair_line_uid"] as? String
                
                let stops = content["stops"] as! [[String:Any]]
                for stop in stops {
                    let station = SubwayStation()
                    station.name = stop["name"] as! String
                    station.uid = stop["uid"] as! String
                    station.x = stop["x"] as! CGFloat
                    station.y = stop["y"] as! CGFloat
                    line.stops.append(station)
                }
                contentData.append(line)
            }
            
            print("Lines:\(contentData.count)")
            

        } catch let e {
            print(e)
        }
        //优化数据
        for line in contentData {
            for station in line.stops {
                //添加本身的
                var cont:Int = 1
                station.lines.append(line.line_uid)
                if line.pair_line_uid != nil {
                    if (line.pair_line_uid?.count)! > 1 {
                        cont = 2
                        station.lines.append(line.pair_line_uid!)
                    }
                }else{
                }
                //查找其他的
                for pline in contentData {
                    for pstation in pline.stops {
                        if station.name == pstation.name && station.uid != pstation.uid && line.line_uid != pline.pair_line_uid {
                            //other
                            if !station.lines.contains(pline.line_uid) {
                                station.lines.append(pline.line_uid)
                            }
                            break
                        }
                    }
                }
                //
                if station.lines.count > cont {
                    station.isTransform = true
                    print("##"+station.name)
                }else{
                    station.isTransform = false
                }
            }
        }
        //test
        foundWay(from: "西直门", to: "北京南站")
    }
    
    func foundWay(from:String, to:String) -> [String] {
        var lines:[String] = []
        for line in contentData {
            for station in line.stops {
                if station.name == from {
                    //任意一个即可
                    lines = station.lines
                    break
                }
            }
        }
        //
        var find = 0
        var gos:[SubwayGo] = []
        //
        for line in lines {
            let go = SubwayGo()
            let path = SubwayPath()
            path.line = foundLine(uid: line)
            for i in 0..<path.line.stops.count {
                let stop = path.line.stops[i]
                if stop.name == from {
                    path.from = i
                    path.to = i
                    go.path.append(path)
                    gos.append(go)
                    break
                }
            }
        }
        
        while find < 3 {
            var set:[Int] = []
            var new:[SubwayGo] = []
            for index in 0..<gos.count {
                let go = gos[index]
                let path = go.path[go.path.count-1]
                
                if path.to < path.line.stops.count - 1 {
                    //next
                    let current = path.line.stops[path.to]
                    
                    if current.name == to {
                        //FIND!!!!
                        print("===========\(find)")
                        for getpath in go.path {
                            print(getpath.line.line_name)
                            for i in getpath.from...getpath.to{
                                print(getpath.line.stops[i].name)
                            }
                        }
                        print("===========")
                        find = find + 1
                        set.append(index)
                    }else if current.isTransform {
                        //change line
                        for l in current.lines {
                            if l == path.line.line_uid || l == path.line.pair_line_uid {
                                //自身pass
                            }else{
                                //是否经过
                                var hadpass = false
                                for p in go.path {
                                    if p.line.line_uid == l {
                                        //pass
                                        hadpass = true
                                        break
                                    }
                                }
                                
                                if !hadpass {
                                    
                                    if path.to != path.from {//第一站不换
                                        let newgo = SubwayGo.init()
                                        newgo.path = getNewPath(go: go)//新建，否则浅拷贝或导致数据问题
                                        let newpath = SubwayPath()
                                        newpath.line = foundLine(uid: l)
                                        for i in 0..<newpath.line.stops.count {
                                            if newpath.line.stops[i].name == current.name {
                                                //ok
                                                newpath.from = i
                                                newpath.to = i
                                                break
                                            }
                                        }
                                        newgo.path.append(newpath)
                                        new.append(newgo)
                                    }else{
                                        //忽略
                                    }
                                }else{
                                    //忽略即可
                                }
                            }
                        }

                        //next
                        path.to += 1
                    }else{
                        //next
                        path.to += 1
                    }
                }else{
                    //环线
                    if path.line.isCircle {
                        //
                        path.to = 0
                        if path.to < path.from {
                            //ok
                            //多环··
                            if path.from - path.to == 1 {
                                //闭环了 弃
                                set.append(index)
                            }
                        }else{
                            //环了 弃了
                            set.append(index)
                        }
                        
                    }else{
                        //弃了
                        set.append(index)
                    }
                }
            }
            //gos 操作
            for i in 0..<set.count {
                gos.remove(at: set[i]-i)
            }
            gos.append(contentsOf: new)
            if gos.count <= 0{
                //noway
                find = find + 3
                break
            }
        }
        
        return []
    }
    
    /// 返回一个路径的复制
    ///
    /// - Parameter go: 路径
    /// - Returns: 复制路径
    func getNewPath(go:SubwayGo) -> [SubwayPath] {
        var new:[SubwayPath] = []
        for path in go.path {
            let newpath = SubwayPath()
            newpath.from = path.from
            newpath.to = path.to
            newpath.line = path.line
            new.append(newpath)
        }
        return new
    }
    
    /// 根据id寻找线路
    ///
    /// - Parameter uid: lineid
    /// - Returns: line
    func foundLine(uid:String) -> SubwayLine{
        for line in contentData {
            if line.line_uid == uid {
                return line
            }
        }
        return SubwayLine()
    }
}

//MARK: - 数据

class SubwayGo:NSObject {
    var path:[SubwayPath] = []//路径
}
class SubwayPath:NSObject {
    var line:SubwayLine = SubwayLine()
    var from:Int = 0
    var to:Int = 0
}

class SubwayStation: SubwayModel {
    var is_practical:Int = 0
    var name = ""
    var uid = ""
    var x:CGFloat = 0
    var y:CGFloat = 0
    
    var lines:[String] = []//保存线路，便于查找
    var isTransform:Bool = false//是否是中转
}

class SubwayLine: SubwayModel {
    var line_name = ""
    var line_uid = ""
    var pair_line_uid:String? = " "
    var stops:[SubwayStation] = []
    var isCircle:Bool = false//是否是环
}

class SubwayContent: SubwayModel {
    var content:[SubwayLine] = []
    var result:SubwayResult = SubwayResult()
}
class SubwayResult: SubwayModel {
    var ccode = ""
    var qt = ""
}

class SubwayModel:HandyJSON {
    
    required init() {}
}
