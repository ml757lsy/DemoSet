//
//  CellularAutomatonViewController.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/6/9.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit

class CellularAutomatonViewController: UIViewController {

    // MARK: - 属性值private
    private var oldEnvironmental:[[Int]] = []//环境变量数组
    private var newEnvironmental:[[Int]] = []
    private var width:Int = 10
    private var height:Int = 10
    private var timer:Timer = Timer()
    
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
        for l in 0..<height {
            for w in 0..<width {
                let v = UIView()
                v.frame = CGRect.init(x: 20+w*10, y: 20+l*10, width: 10, height: 10)
                v.tag = l*1000+w+1024
                v.backgroundColor = UIColor.red
                view.addSubview(v)
            }
        }
    }
    
    func updateCellularAutomationView() {
        for l in 0..<height {
            let line = newEnvironmental[l]
            for w in 0..<width {
                let n = newEnvironmental[l][w]
                let v = view.viewWithTag(l*1000+w+1024)
                if n==1 {
                    v?.backgroundColor = UIColor.blue
                }else{
                    v?.backgroundColor = UIColor.white
                }
            }
        }
    }
    
    // MARK: - 功能函数
    func initEnvironmental() {
        for _ in 0..<height {
            var line:[Int] = []
            for _ in 0..<width {
                line.append(0)
            }
            newEnvironmental.append(line)
            oldEnvironmental.append(line)
        }
    }
    
    func setStart() {
        oldEnvironmental[4][4] = 1
        oldEnvironmental[4][5] = 1
        oldEnvironmental[4][6] = 1
        oldEnvironmental[5][4] = 1
        oldEnvironmental[5][5] = 1
        oldEnvironmental[5][6] = 1
        oldEnvironmental[6][4] = 1
        oldEnvironmental[6][5] = 1
        oldEnvironmental[6][6] = 1
        updateCellularAutomationView()
    }
    
    func startEvolution(){
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (timer) in
            self.nextGeneration()
        })
    }
    
    func nextGeneration() {
        for l in 0..<height {
            for w in 0..<width {
                var count = 0
                //top
                if l > 0 {
                    let topline = oldEnvironmental[l-1]
                    if w>0 {
                        let n = topline[w-1]
                        if n>0 {
                            count += 1
                        }
                    }
                    let n = topline[w]
                    if n>0 {
                        count += 1
                    }
                    if w<width-1 {
                        let n = topline[w+1]
                        if n>0 {
                            count += 1
                        }
                    }
                }
                //l
                let line = oldEnvironmental[l]
                if w>0 {
                    let n = line[w-1]
                    if n>0 {
                        count += 1
                    }
                }
                let n = line[w]
                if n>0 {
                    count += 1
                }
                if w<width-1 {
                    let n = line[w+1]
                    if n>0 {
                        count += 1
                    }
                }
                //bottom
                if l<height-1 {
                    //
                    let bottomline = oldEnvironmental[l+1]
                    if w>0 {
                        let n = bottomline[w-1]
                        if n>0 {
                            count += 1
                        }
                    }
                    let n = bottomline[w]
                    if n>0 {
                        count += 1
                    }
                    if w<width-1 {
                        let n = bottomline[w+1]
                        if n>0 {
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
                    newEnvironmental[l][w] = 1
                }else{
                    newEnvironmental[l][w] = 0
                }
            }
        }
        oldEnvironmental = newEnvironmental
        updateCellularAutomationView()
    }
    
    // MARK: - 代理方法
    
    // MARK: - 其他

}
