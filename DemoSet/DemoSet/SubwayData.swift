//
//  SubwayData.swift
//  MyApp
//
//  Created by LiShiyuan on 2017/4/6.
//  Copyright © 2017年 com.ml.app. All rights reserved.
//

import UIKit

/// 站结构
struct Station {
    
    /// 站点ID
    var stationID:Int = 0
    
    /// 名字
    var name:String = ""
    
    /// 所属线路
    var lines = [Int]()
    
    /// 临近站
    var next = [Int]()
    
    /// 临近站距离
    var nextDistance = [CGFloat]()
    
    /// 地图位置
    var position:CGPoint =  CGPoint.zero//默认的scence为中心
    
    /// 简化位置
    var simplePostion:CGPoint = CGPoint.zero//
    
    /// 可用
    var isPractical:Bool = true
}

/// 线结构
struct Line {
    var name:String = ""
    var id:Int = 0
    var stations = [Int]()
    var cross = [Int]()
}

/// 人结构
class People {
    var id:Int = 0
    var way = [Int]()
    var change:Int = 0//换乘次数
}

/// 错误类型
///
/// - stationError: 站错误
/// - lineError: 线错误
enum SubwayInitError : Error{
    case stationError
    case lineError
}

/// 数据类
class SubwayData {
    
    private var lines = [Line]()
    private var stations = [Station]()
    
    var peopleID:Int = 0
    var peopleStop = false
    var peopleFound:Int = 0
    var step:Int = 0
    var passedstation = [Int]()
    
    
    var lineFound:Int = 0
    var linepeoplestop = false
    
    
    /// 默认数据库
    static let defaultSubwayData = SubwayData()
    
    private init() {
        initData()
    }
    
    //MARK: - 初始化数据
    private func initData() {
        let path = Bundle.main.path(forResource: "StationData", ofType: "plist")
        if path == nil {
            print("no stations")
            return
        }
        let stationArray:NSArray = NSArray.init(contentsOf: URL.init(fileURLWithPath: path!))!
        
        for s in stationArray {
            let sta = s as! Dictionary<String, Any>
            
            do {
                try addStation(info: sta)
            } catch {
                switch error {
                case SubwayInitError.stationError:
                    print("ERROR:--Station:\(sta["stationID"])")
                    break
                case SubwayInitError.lineError:
                    print("--")
                    break
                default:
                    break
                }
            }
        }
        
        
        //lines
        let linePath = Bundle.main.path(forResource: "LineData", ofType: "plist")
        if linePath == nil {
            print("no lines")
            return
        }
        let lineArray = NSArray.init(contentsOf: URL.init(fileURLWithPath: linePath!))!
        
        for l in lineArray {
            
            let templine = l as! Dictionary<String, Any>
            
            do {
                try addLine(info: templine)
            } catch  {
                switch error {
                case SubwayInitError.stationError:
                    //
                    print("--")
                    break
                case SubwayInitError.lineError:
                    //
                    print("ERROR:--Line:\(templine["id"])")
                    break
                default: break
                    //
                }
            }
        }
    }
    
    func loadDataFromSql() {

    }
    
    
    /// 站点添加
    ///
    /// - Parameter info: info
    /// - Throws: 异常处理
    func addStation(info:Dictionary<String, Any>) throws {
        
        var station = Station()
        
        guard let sid = info["stationID"] as! Int? else {
            throw SubwayInitError.stationError
        }
        station.stationID = sid
        
        guard let sname = info["name"] as! String? else {
            throw SubwayInitError.stationError
        }
        station.name = sname
        
        guard let slines = info["lines"] as! [Int]? else {
            throw SubwayInitError.stationError
        }
        station.lines = slines
        
        guard let snext = info["next"] as! [Int]? else {
            throw SubwayInitError.stationError
        }
        station.next = snext
        
        guard let snextdis = info["nextDistance"] as! [CGFloat]? else {
            throw SubwayInitError.stationError
        }
        station.nextDistance = snextdis
        
        stations.append(station)
    }
    
    /// 线路添加
    ///
    /// - Parameter info: 信息字典
    /// - Throws: 异常处理
    func addLine(info:Dictionary<String, Any>) throws {
        var line = Line()
        
        guard let lid = info["id"] as! Int? else {
            throw SubwayInitError.lineError
        }
        line.id = lid
        
        guard let lname = info["name"] as! String? else {
            throw SubwayInitError.lineError
        }
        line.name = lname
        
        guard let lstations = info["stations"] as! [Int]? else {
            throw SubwayInitError.lineError
        }
        line.stations = lstations
        
        guard let lcross = info["cross"] as! [Int]? else {
            throw SubwayInitError.lineError
        }
        line.cross = lcross
        
        lines.append(line)
    }
    
    
    /// id获取line
    ///
    /// - Parameter lineid: id
    /// - Returns: line
    func getLine(with lineid:Int) -> Line {
        for line in lines {
            if line.id == lineid {
                return line
            }
        }
        return Line()
    }
    
    /// id获取站点
    ///
    /// - Parameter stationid: 站点id
    /// - Returns: 站点
    func getStation(with stationid:Int) -> Station {
        for station in stations {
            if station.stationID == stationid {
                return station
            }
        }
        return Station()
    }
    
    /// 获取线路的交叉线路
    ///
    /// - Parameter lineid: 线路id
    /// - Returns: 线路
    func getCrossLine(with lineid:Int) -> [Int] {
        for line in lines {
            if line.id == lineid {
                return line.cross
            }
        }
        return []
    }
    
    /// 找
    func getWay(from stationoid:Int, to station:Int, result:@escaping (_:[Line])->Void){
        
        getTheLineWay(from: stations[275], to: stations[234])

        result([])
    }
    
    func saveStation() {
        return
        let path = Bundle.main.path(forResource: "StationData", ofType: "plist")
        
        var s = NSMutableArray.init()
        
        for station in stations {
            var dic = NSMutableDictionary.init()
            dic.setValue(station.stationID, forKey: "stationID")
            dic.setValue(station.name, forKey: "name")
        }
        
        if s.write(toFile: path!, atomically: true) {
            print("save success")
        }
    }
    
    
    //MARK: - 线路算法
    func getTheLineWay(from station:Station, to aim:Station) {
        let startLines = station.lines
        let aimLines = aim.lines
        var peoples = [People]()
        for startline in startLines {
            let people = People()
            people.way.append(startline)
            peoples.append(people)
        }
        getTheNextLine(with: peoples, and: aimLines)
    }
    
    /// 一步一线寻找
    ///
    /// - Parameters:
    ///   - peoples: peoples
    ///   - aimlines: 目标线路
    func getTheNextLine(with peoples:[People], and aimlines:[Int]) {
        if peoples.count <= 0 {
            return
        }
        if linepeoplestop {
            return
        }
        
        var newpeoples = [People]()
        for people in peoples {
            if linepeoplestop {
                return
            }
            let last = people.way.last!
            if aimlines.contains(last) {
                //GOT
                foundTheLineWay(with: people)
            }else{
                let cross = getCrossLine(with: last)
                for nextline in cross {
                    if !people.way.contains(nextline) {
                        //没有就加
                        let newpeople = People()
                        newpeople.way += people.way
                        newpeople.way.append(nextline)
                        newpeople.change = people.change + 1
                        newpeoples.append(newpeople)
                    }
                }
            }
        }
        getTheNextLine(with: newpeoples, and: aimlines)
    }
    
    func foundTheLineWay(with people:People) {
        print("Line:\(people.way)")
        handleLineStop()
        //线路齐了，开走
        let stationpeople = People()
        stationpeople.id = peopleID
        stationpeople.way.append(stations[275].stationID)
        //找到一条线就寻找呢还是先存放后排序再寻找···
        //条数不一定会多，所以定定时器比较合理
        getNextStep(with: [stationpeople], and: 235, through: people.way)
    }
    
    func handleLineStop() {
        lineFound += 1
        peopleFound = 0
        if lineFound >= 6 {//默认的话是3条路线,一般来说都是越快越早
            print("三条线路")
            linepeoplestop = true
        }
    }
    
    
    //MARK: - 蚁群算法
    func getTheWay(from station:Station, to aim:Station){
        let people = People()
        people.id = peopleID
        people.way.append(station.stationID)
        getNextStep(with: [people], and: aim.stationID)
    }
    
    /// 一步一站式寻找
    ///
    /// - Parameters:
    ///   - peoples: peoples
    ///   - aim: aim
    func getNextStep(with peoples:[People], and aim:Int) {
        if peopleStop {
            return
        }
        if peoples.count < 1 {
            return
        }
        
        var newpeoples = [People]()
        for people in peoples {
            var passedway = [Int]()
            passedway += people.way
            if passedway.count < 1 {
                falseTheWay(people: people)
                break
            }
            if peopleStop {
                return
            }
            if passedway.count > 60 {//超限
                falseTheWay(people: people)
                print("超限啊")
                break
            }
            let currentid = passedway.last
            let now = getStation(with: currentid!)
            //是now么
            if now.stationID == aim {
                theWayFind(with: people)
                
                continue
            }
            
            if people.way.count > 1 {
                //路过
                var nexts = [Int]()
                for next in now.next {
                    var had = false
                    for passed in people.way {
                        if passed == next {
                            had = true
                            break
                        }
                    }
                    if !had {
                        nexts.append(next)
                    }
                }
                //nexts排序 不换为先
                
                let passedway = people.way
                for nextid in nexts {
                    //判断是否有了  ````
                    var index = 0
                    for i in 0..<passedstation.count {
                        if passedstation[i] == nextid {
                            index = i
                        }
                    }
                    if index > passedstation.count/2 {
                        //说明之前有一个已经走过这个站了
                    }else{
                        let newpeople = People()
                        newpeople.way += passedway
                        newpeople.way.append(nextid)
                        newpeoples.append(newpeople)
                        step += 1
                    }
                }
                for nextid in nexts {
                    passedstation.append(nextid)
                }
                continue
            }else{
                //起点
                let passedway = people.way
                for next in now.next {
                    let newpeople = People()
                    newpeople.way += passedway
                    newpeople.way.append(next)
                    newpeoples.append(newpeople)
                    step += 1
                    passedstation.append(next)
                }
                continue
            }
        }
        
        getNextStep(with: newpeoples, and: aim)
    }
    
    /// 一步一站寻找
    ///
    /// - Parameters:
    ///   - peoples: people
    ///   - aim: aim
    ///   - lines: lines
    func getNextStep(with peoples:[People], and aim:Int, through lines:[Int]){
        if peopleStop {
            return
        }
        if peoples.count < 1 {
            return
        }
        
        
        var newpeoples = [People]()
        for people in peoples {
            var passedway = [Int]()
            passedway += people.way
            if passedway.count < 1 {
                falseTheWay(people: people)
                break
            }
            if peopleStop {
                return
            }
            if passedway.count > 60 {//超限
                falseTheWay(people: people)
                print("超限啊")
                break
            }
            let currentid = passedway.last
            let now = getStation(with: currentid!)
            //是now么
            if now.stationID == aim {
                theWayFind(with: people)
                
                continue
            }
            
            if people.way.count > 1 {
                //路过
                var nexts = [Int]()
                for next in now.next {
                    var had = false
                    for passed in people.way {
                        if passed == next {
                            had = true
                            break
                        }
                    }
                    if !had {
                        nexts.append(next)
                    }
                }
                
                let passedway = people.way
                for nextid in nexts {
                    //判断是否是通过目标线路
                    let nextstation = getStation(with: nextid)
                    var through = false
                    for nextline in nextstation.lines {
                        for line in lines {
                            if line == nextline {
                                through = true
                                break
                            }
                        }
                        if through {
                            break
                        }
                    }
                    
                    if !through {
                        //不按制定的就算了
                        //                        print("不走的路 \(people.way.last!)--->next:\(nextid)")
                    }else{
                        let newpeople = People()
                        newpeople.way += passedway
                        newpeople.way.append(nextid)
                        newpeoples.append(newpeople)
                        step += 1
                    }
                }
                continue
            }else{
                //起点
                //一般来说无所谓
                //也可以判断一下 万一起始是中转站
                let passedway = people.way
                for next in now.next {
                    let newpeople = People()
                    newpeople.way += passedway
                    newpeople.way.append(next)
                    newpeoples.append(newpeople)
                    step += 1
                    passedstation.append(next)
                }
                continue
            }
        }
        
        getNextStep(with: newpeoples, and: aim, through: lines)
    }
    
    /// 某某已找到
    ///
    /// - Parameter people: people
    func theWayFind(with people:People) -> Line{
        print("*******SUCCESS:\(people.way.count)站******")
        for s in people.way {
            let station = getStation(with: s)
            print("\(station.name)")
        }
        print("运算次数:\(step)")
        print("********************")
        handleStop()
        
        var line = Line()
        line.stations += people.way
        
        return line
    }
    
    /// 失败的
    ///
    /// - Parameter people: //
    func falseTheWay(people:People){
        print("----FALSE:\(people.id):\(people.way)")
    }
    
    /// 停止处理事件
    func handleStop() {
        peopleFound += 1
        if peopleFound >= 3 {//默认的话是3条路线,一般来说都是越快越早
            print("足够了！！！")
            peopleStop = true
        }
    }

}
