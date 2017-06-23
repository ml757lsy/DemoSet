//
//  CellularAutomatonViewController.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/6/9.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit

class CellularAutomatonViewController: BaseViewController {

    // MARK: - 属性值private
    private var oldEnvironmental:[[Cellular]] = []//环境变量数组
    private var newEnvironmental:[[Cellular]] = []
    private var width:Int = 50
    private var height:Int = 50
    private var timer:Timer = Timer()
    private let generationLabel:UILabel = UILabel()
    private var generation:Int = 0
    
    // MARK: - 对外接口
    
    // MARK: - 生命周期与复写
    override func viewDidLoad() {
        super.viewDidLoad()

        initEnvironmental()
        initCellularAutomationView()
        setStart()
        startEvolution()
        view.backgroundColor = UIColor.green
        
        let set = UIButton()
        set.frame = CGRect.init(x: view.frame.size.width-100, y: 20, width: 60, height: 40)
        set.setTitle("设置", for: .normal)
        set.addTarget(self, action: #selector(setStart), for: .touchUpInside)
    }
    
    // MARK: - 界面布局
    func initCellularAutomationView() {
        let cellWidth = (view.frame.size.width-20)/CGFloat(width)
        
        for l in 0..<height {
            for w in 0..<width {
                let v = UIView()
                v.frame = CGRect.init(x: 10+CGFloat(w)*cellWidth, y: 10+CGFloat(l)*cellWidth, width: cellWidth, height: cellWidth)
                v.tag = l*1000+w+1024
                v.backgroundColor = UIColor.red
                view.addSubview(v)
            }
        }
        view.addSubview(generationLabel)
        generationLabel.frame = CGRect.init(x: 10, y: CGFloat(height)*cellWidth+10+20, width: 150, height: 20)
        generationLabel.textColor = UIColor.white
    }
    
    func updateCellularAutomationView() {
        for l in 0..<height {
            for w in 0..<width {
                let sprite = newEnvironmental[l][w]
                let v = view.viewWithTag(l*1000+w+1024)
                
                //根据类型显示
                switch sprite.type {
                case .null:
                    v?.backgroundColor = UIColor.white
                    break
                case .ground:
                    v?.backgroundColor = UIColor.green
                    break
                case .cell:
                    if sprite.liveState.rawValue > 0 {
                        //
                        v?.backgroundColor = UIColor.blue
                    }else{
                        v?.backgroundColor = UIColor.cyan
                    }
                    
                    break
                default:
                    v?.backgroundColor = UIColor.black
                    break
                }

            }
        }
    }
    
    // MARK: - 功能函数
    func initEnvironmental() {
        for _ in 0..<height {
            var line:[Cellular] = []
            for _ in 0..<width {
                var cell = Cellular()
                cell.type = .null
                line.append(cell)
            }
            newEnvironmental.append(line)
            oldEnvironmental.append(line)
        }
    }
    
    func setStart() {
        oldEnvironmental[4][4].type = .cell
        oldEnvironmental[4][5].type = .cell
        oldEnvironmental[4][6].type = .cell
        oldEnvironmental[5][4].type = .cell
        oldEnvironmental[5][5].type = .cell
        oldEnvironmental[5][6].type = .cell
        oldEnvironmental[6][4].type = .cell
        oldEnvironmental[6][5].type = .cell
        oldEnvironmental[6][6].type = .cell
        updateCellularAutomationView()
    }
    
    func startEvolution(){
        timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true, block: { (timer) in
            self.nextGeneration()
        })
    }
    
    func nextGeneration() {
        generation += 1
        generationLabel.text = "\(generation)代"
        for l in 0..<height {
            for w in 0..<width {
                check(line: l, wid: w)
            }
        }
        oldEnvironmental = newEnvironmental
        updateCellularAutomationView()
        
        /*
         let sign = oldEnvironmental[l][w].type
         
         var count = 0
         //top
         if l > 0 {
         let topline = oldEnvironmental[l-1]
         if w>0 {
         let n = topline[w-1].type
         if n.rawValue > CellularType.null.rawValue {
         count += 1
         }
         }
         let n = topline[w].type
         if n.rawValue > CellularType.null.rawValue{
         count += 1
         }
         if w<width-1 {
         let n = topline[w+1].type
         if n.rawValue > CellularType.null.rawValue {
         count += 1
         }
         }
         }
         //l
         let line = oldEnvironmental[l]
         if w>0 {
         let n = line[w-1].type
         if n.rawValue > CellularType.null.rawValue {
         count += 1
         }
         }
         
         if w<width-1 {
         let n = line[w+1].type
         if n.rawValue > CellularType.null.rawValue {
         count += 1
         }
         }
         //bottom
         if l<height-1 {
         //
         let bottomline = oldEnvironmental[l+1]
         if w>0 {
         let n = bottomline[w-1].type
         if n.rawValue > CellularType.null.rawValue {
         count += 1
         }
         }
         let n = bottomline[w].type
         if n.rawValue > CellularType.null.rawValue {
         count += 1
         }
         if w<width-1 {
         let n = bottomline[w+1].type
         if n.rawValue > CellularType.null.rawValue {
         count += 1
         }
         }
         }
         //check
         var live:Bool = true
         if count > 5 {
         live = false
         }
         if count < 2 {
         live = false
         }
         
         if live {
         newEnvironmental[l][w].type = .ground
         }else{
         newEnvironmental[l][w].type = .null
         }

         */
    }
    
    func check(line:Int, wid:Int) {
        //检测对象
        var cell = oldEnvironmental[line][wid]
        if cell.type == .cell {
            if cell.liveState == .die {//已死的重新轮回
                cell.type = .ground
                cell.liveState = .live
                return
            }
        }
        //划定检测范围
        var lmin = line - cell.range
        if lmin < 0 {
            lmin = 0
        }
        var lmax = line + cell.range
        if lmax >= height {
            lmax = height - 1
        }
        var wmin = wid - cell.range
        if wmin < 0 {
            wmin = 0
        }
        var wmax = wid + cell.range
        if wmax >= width {
            wmax = width - 1
        }
        //统计数据
        var similar = 0//同类
        var food = 0
        
        for l in lmin...lmax {
            for w in wmin...wmax {
                if l == line && w == wid {
                    continue//忽略自己
                }
                let c = oldEnvironmental[l][w]
                //具体操作
                if c.type == cell.type && c.liveState != .die {
                    similar += 1
                }
                
            }
        }
        if similar > cell.maxSuport {
            //die
            cell.liveState = .die
        }
        if similar < cell.minSuport {
            //die
            cell.liveState = .die
        }
        
        //判断完的赋值给新的
        newEnvironmental[line][wid].type = cell.type
    }
    
    // MARK: - 代理方法
    
    // MARK: - 其他

}
