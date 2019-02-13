//
//  MinesweeperViewController.swift
//  DemoSet
//
//  Created by 李世远 on 2019/2/1.
//  Copyright © 2019 Far. All rights reserved.
//

import UIKit

/// 扫雷
class MinesweeperViewController: BaseViewController {
    
    var maxMine:Int = 0//最大雷数
    var width:Int = 0
    var height:Int = 0
    var open:Int = 0//已开
    var map:[[Int]] = []//地图
    
    let Mine:Int = 9
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        baseInit()
    }
    
    /// 生成数据
    func baseInit() {
        
        //test
        maxMine = 10
        width = 10
        height = 10
        
        map.removeAll()
        for _ in 0..<height {
            var line:[Int] = []
            for _ in 0..<width {
                line.append(0)
            }
            map.append(line)
        }
        
        setMine()
    }
    
    /// 布雷
    func setMine() {
        var m = maxMine
        while m > 0 {
            //p
            let x = Int(arc4random())%width
            let y = Int(arc4random())%height
            //add?
            if map[x][y] == 0 {
                map[x][y] = Mine//mine
                m -= 1
            }
        }
        
        setNotiNumber()
    }
    
    /// 设置提示数字
    func setNotiNumber() {
        
        for y in 0..<height {
            for x in 0..<width {
                map[y][x] = getMineNumAround(x: x, y: y, map: map)
            }
        }
        
        //
        setOther()
    }
    
    /// 其他设置
    func setOther() {
        for y in 0..<height {
            for x in 0..<width {
                let button = UIButton.init(frame: CGRect.init(x: x*30, y: y*30, width: 30, height: 30))
                button.setTitle("\(map[y][x])", for: .normal)
                button.tag = y*10000+x
                button.setTitleColor(UIColor.blue, for: .normal)
                button.addTarget(self, action: #selector(mineClick(button:)), for: .touchUpInside)
                view.addSubview(button)
            }
        }
        
        start()
    }
    
    /// 开始
    func start() {
        
    }
    
    func mineClick(button:UIButton) {
        let x = button.tag % 10000
        let y = button.tag/10000
        
        let list = shouldOpen(x: x, y: y, map: map)
        print(list)
        //去打开并检测
        //1 是不是Mine
        //>1 ok
    }
    
    /// 获取某点的周围数量
    ///
    /// - Parameters:
    ///   - x: x
    ///   - y: y
    ///   - map: map
    /// - Returns: num
    func getMineNumAround(x:Int, y:Int, map:[[Int]]) -> Int {
        
        if map[y][x] == Mine {
            return Mine//直接返回即可
        }
        var m = 0
        
        if y > 0 {
            if x > 0 {
                if map[y-1][x-1] == Mine {
                    m += 1
                }
            }
            
            if map[y-1][x] == Mine {
                m += 1
            }
            
            if x < width-1 {
                if map[y-1][x+1] == Mine {
                    m += 1
                }
            }
        }
        
        if x > 0 {
            if map[y][x-1] == Mine {
                m += 1
            }
        }
        if x < width-1 {
            if map[y][x+1] == Mine {
                m += 1
            }
        }
        
        if y < height - 1  {
            if x > 0 {
                if map[y+1][x-1] == Mine {
                    m += 1
                }
            }
            
            if map[y+1][x] == Mine {
                m += 1
            }
            
            if x < width-1 {
                if map[y+1][x+1] == Mine {
                    m += 1
                }
            }
        }
        
        return m
    }
    
    /// 自动打开的路径
    ///
    /// - Parameters:
    ///   - x: x
    ///   - y: y
    ///   - map: map
    /// - Returns: list
    func shouldOpen(x:Int, y:Int, map:[[Int]]) -> [MinePoint] {
        var path:[MinePoint] = []//遍历过的
        var temp:[MinePoint] = []//新的
        
        temp.append(MinePoint.init(x: x, y: y))
        
        while temp.count > 0 {
            let p = temp[0]
            let x = p.x
            let y = p.y
            
            if y > 0 {
                if x > 0 {
                    if map[y-1][x-1] == 0 {
                        //
                        if temp.contains(where: { (a) -> Bool in
                            return a.x == x-1 && a.y == y-1
                        })||path.contains(where: { (a) -> Bool in
                            return a.x == x-1 && a.y == y-1
                        }) {
                            //任何一个有的话那就算了
                        }else{
                            //添加上吧
                            temp.append(MinePoint.init(x: x-1, y: y-1))
                        }
                    }
                }
                
                if map[y-1][x] == 0 {
                    //
                    if temp.contains(where: { (a) -> Bool in
                        return a.x == x && a.y == y-1
                    })||path.contains(where: { (a) -> Bool in
                        return a.x == x && a.y == y-1
                    }) {
                        //任何一个有的话那就算了
                    }else{
                        //添加上吧
                        temp.append(MinePoint.init(x: x, y: y-1))
                    }
                }
                
                if x < width-1 {
                    if map[y-1][x+1] == 0 {
                        //
                        if temp.contains(where: { (a) -> Bool in
                            return a.x == x+1 && a.y == y-1
                        })||path.contains(where: { (a) -> Bool in
                            return a.x == x+1 && a.y == y-1
                        }) {
                            //任何一个有的话那就算了
                        }else{
                            //添加上吧
                            temp.append(MinePoint.init(x: x+1, y: y-1))
                        }
                    }
                }
            }
            
            if x > 0 {
                if map[y][x-1] == 0 {
                    //
                    if temp.contains(where: { (a) -> Bool in
                        return a.x == x-1 && a.y == y
                    })||path.contains(where: { (a) -> Bool in
                        return a.x == x-1 && a.y == y
                    }) {
                        //任何一个有的话那就算了
                    }else{
                        //添加上吧
                        temp.append(MinePoint.init(x: x-1, y: y))
                    }
                }
            }
            if x < width-1 {
                if map[y][x+1] == 0 {
                    //
                    if temp.contains(where: { (a) -> Bool in
                        return a.x == x+1 && a.y == y
                    })||path.contains(where: { (a) -> Bool in
                        return a.x == x+1 && a.y == y
                    }) {
                        //任何一个有的话那就算了
                    }else{
                        //添加上吧
                        temp.append(MinePoint.init(x: x+1, y: y))
                    }
                }
            }
            
            if y < height - 1  {
                if x > 0 {
                    if map[y+1][x-1] == 0 {
                        //
                        if temp.contains(where: { (a) -> Bool in
                            return a.x == x-1 && a.y == y+1
                        })||path.contains(where: { (a) -> Bool in
                            return a.x == x-1 && a.y == y+1
                        }) {
                            //任何一个有的话那就算了
                        }else{
                            //添加上吧
                            temp.append(MinePoint.init(x: x-1, y: y+1))
                        }
                    }
                }
                
                if map[y+1][x] == 0 {
                    //
                    if temp.contains(where: { (a) -> Bool in
                        return a.x == x && a.y == y+1
                    })||path.contains(where: { (a) -> Bool in
                        return a.x == x && a.y == y+1
                    }) {
                        //任何一个有的话那就算了
                    }else{
                        //添加上吧
                        temp.append(MinePoint.init(x: x, y: y+1))
                    }
                }
                
                if x < width-1 {
                    if map[y+1][x+1] == 0 {
                        //
                        if temp.contains(where: { (a) -> Bool in
                            return a.x == x+1 && a.y == y+1
                        })||path.contains(where: { (a) -> Bool in
                            return a.x == x+1 && a.y == y+1
                        }) {
                            //任何一个有的话那就算了
                        }else{
                            //添加上吧
                            temp.append(MinePoint.init(x: x+1, y: y+1))
                        }
                    }
                }
            }
            //
            path.append(temp[0])
            temp.remove(at: 0)
        }
        
        return path
    }
    
    public struct MinePoint {
        public var x: Int
        
        public var y: Int
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
