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
    
    private var secV:UIView = UIView()
    private var aimV:UIView = UIView()
    private var breakSort:Bool = false
    
    // MARK: - 对外接口
    
    // MARK: - 生命周期与复写
    override func viewDidLoad() {
        super.viewDidLoad()

        edgesForExtendedLayout = .init(rawValue: 0)
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
        
        let insert = UIButton()
        view.addSubview(insert)
        insert.frame = CGRect.init(x: 20, y: 20+400+40, width: 60, height: 40)
        insert.setTitle("Insert", for: .normal)
        insert.setTitleColor(UIColor.orange, for: .normal)
        insert.addTarget(self, action: #selector(insertSort), for: .touchUpInside)
        
        let compare = UIButton()
        view.addSubview(compare)
        compare.frame = CGRect.init(x: 100, y: 20+400+40, width: 60, height: 40)
        compare.setTitle("compare", for: .normal)
        compare.setTitleColor(UIColor.orange, for: .normal)
        compare.addTarget(self, action: #selector(compareSort), for: .touchUpInside)
        
        let quick = UIButton()
        view.addSubview(quick)
        quick.frame = CGRect.init(x: 180, y: 20+400+40, width: 60, height: 40)
        quick.setTitle("quickSort", for: .normal)
        quick.setTitleColor(UIColor.orange, for: .normal)
        quick.addTarget(self, action: #selector(quickSort), for: .touchUpInside)
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
    
    @objc func insertSort() {
        
        DispatchQueue.global().async {
            for i in 0..<self.list.count {
                for j in i..<self.list.count {
                    
                    if self.breakSort {//中断
                        return
                    }
                    
                    if self.list[i] > self.list[j] {
                        let temp = self.list[i]
                        self.list[i] = self.list[j]
                        self.list[j] = temp
                    }
                    Thread.sleep(forTimeInterval: 0.04)//延时表示
                    DispatchQueue.main.async {
                        self.secV.frame = self.columns[i].frame
                        self.aimV.frame = self.columns[j].frame
                        self.columns[i].sortValue = self.list[i]
                        self.columns[j].sortValue = self.list[j]
                    }
                }
            }
            self.breakSort = false
        }
    }
    
    @objc func compareSort() {
    }
    @objc func quickSort() {
        startquickSort(from: 0, to: list.count-1)
    }
    
    func startquickSort(from:Int, to end:Int) {
        print("\(from)--\(end)")
        DispatchQueue.global().async {
            if end-from <= 0 {
                return
            }else{
                let key = self.list[from]
                var index = from
                
                for i in from+1...end {
                    if self.list[i] < key {
                        self.list.insert(self.list[i], at: from)
                        self.list.remove(at: i+1)
                        index += 1
                        
                        Thread.sleep(forTimeInterval: 0.04)//延时表示
                        DispatchQueue.main.async {
                            self.secV.frame = self.columns[from].frame
                            self.aimV.frame = self.columns[i].frame
                            
                        }
                        print(self.list)
                    }
                    self.secV.frame = self.columns[from].frame
                }
                
                self.startquickSort(from: Int(from), to: Int(index-1))
                self.startquickSort(from: Int(index+1), to: Int(end))
            }
        }
    }
    
    // MARK: - 代理方法
    
    // MARK: - 其他

}
