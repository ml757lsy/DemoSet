//
//  SortViewController.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/6/13.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit

class SortViewController: BaseViewController {
    // MARK: - 属性值private
    private var list:[Int] = []
    private var columns:[SortColumn] = []
    private var left:Int = 0
    private var right:Int = 0
    private var timer:Timer = Timer()
    private var secV:UIView = UIView()
    private var aimV:UIView = UIView()
    
    // MARK: - 对外接口
    
    // MARK: - 生命周期与复写
    override func viewDidLoad() {
        super.viewDidLoad()

        initSortView()
        initData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - 界面布局
    func initSortView() {
        let columnWidth:CGFloat = (view.width-40)/20
        for i in 0..<20 {
            let column = SortColumn()
            column.frame = CGRect.init(x: 20+CGFloat(i)*columnWidth, y: 20, width: columnWidth-1, height: 20)
            view.addSubview(column)
            columns.append(column)
        }
        view.addSubview(secV)
        secV.layer.borderWidth = 1
        secV.layer.borderColor = UIColor.red.cgColor
        
        view.addSubview(aimV)
        aimV.layer.borderWidth = 1
        aimV.layer.borderColor = UIColor.blue.cgColor
        
        let start = UIButton()
        view.addSubview(start)
        start.frame = CGRect.init(x: 20, y: 20+400+40, width: 60, height: 40)
        start.setTitle("Start", for: .normal)
        start.addTarget(self, action: #selector(popsort), for: .touchUpInside)
        
        let compare = UIButton()
        view.addSubview(compare)
        compare.frame = CGRect.init(x: 20, y: 60+400+40, width: 60, height: 40)
        compare.setTitle("compare", for: .normal)
        compare.addTarget(self, action: #selector(compareSort), for: .touchUpInside)
    }
    
    // MARK: - 功能函数
    func initData() {
        list.removeAll()
        for i in 1...20 {
            list.append(i)
        }
        random()
    }
    
    func random() {
        //乱序
        for i in 0..<20 {
            //
            let next = (Int(arc4random()%20) + i)%20
            let n = list[next]
            list[next] = list[i]
            list[i] = n
        }
        
        for i in 0..<20 {
            let column = columns[i]
            column.sortValue = list[i]
        }
    }
    
    func popsort() {
        timer.invalidate()
        left = 0
        right = 0
        random()
        
        timer = Timer.scheduledTimer(timeInterval: 0.03, target: self, selector: #selector(sort), userInfo: nil, repeats: true)
    }
    func compareSort() {
        timer.invalidate()
        left = 0
        right = 0
        random()
        
        timer = Timer.scheduledTimer(timeInterval: 0.03, target: self, selector: #selector(compare), userInfo: nil, repeats: true)
    }
    
    func sort(){
        right += 1
        if right >= list.count {
            right = left+1
            left += 1
        }
        if left >= list.count {
            timer.invalidate()
            return
        }
        secV.frame = columns[left].frame
        aimV.frame = columns[right].frame
        
        if list[left]>list[right] {
            let n = list[left]
            list[left] = list[right]
            list[right] = Int(n)
            columns[left].sortValue = list[left]
            columns[right].sortValue = list[right]
        }
    }
    
    func compare() {
        right += 1
        if right >= list.count-1 {
            right = 0
            left += 1
        }
        if left >= list.count {
            timer.invalidate()
            return
        }
        secV.frame = columns[right].frame
        aimV.frame = columns[right+1].frame
        
        if list[right]>list[right+1] {
            let n = list[right]
            list[right] = list[right+1]
            list[right+1] = Int(n)
            columns[right].sortValue = list[right]
            columns[right+1].sortValue = list[right+1]
        }
    }
    
    // MARK: - 代理方法
    
    // MARK: - 其他

}
