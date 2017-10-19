//
//  MathViewController.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/10/19.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit

/// 数学相关的好多玩意
class MathViewController: BaseViewController {
    
    private let FibonacciLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //view
    func initView() {
        let FibonacciButton = UIButton.init(type: .custom)
        FibonacciButton.frame = CGRect.init(x: 20, y: 60, width: 100, height: 40)
        view.addSubview(FibonacciButton)
        FibonacciButton.setTitle("Fibonacci", for: .normal)
        FibonacciButton.setTitleColor(UIColor.orange, for: .normal)
        FibonacciButton.addTarget(self, action: #selector(Fibinacci), for: .touchUpInside)
        
        view.addSubview(FibonacciLabel)
        FibonacciLabel.frame = CGRect.init(x: 20, y: 100, width: 200, height: 200)
        FibonacciLabel.numberOfLines = 0
    }
    
    /// 大数相关
    func bignum() {
        
    }
    /// 计算斐波那契数
    func Fibinacci() {
        let index = 40
        
        let s = Date()
        let n = getFibonacciNum(at: index)
        let end = Date()
        let d = end.timeIntervalSince1970-s.timeIntervalSince1970
        
        let ns = Date()
        let nn = getFibonacciNum(at: index-2, with: 1, and: 1)
        let ne = Date()
        let nd = ne.timeIntervalSince1970-ns.timeIntervalSince1970

        FibonacciLabel.text = "计算第\(index)位斐波那契数\n结果\(n)--\(nn)\n递归用时:\(d)\n尾递归用时:\(nd)"
    }
    
    //尾递归
    func getFibonacciNum(at index:Int, with a:Int, and b:Int) -> Int {
        var newindex = index
        if index > 0 {
            newindex -= 1
            
            return getFibonacciNum(at:newindex, with:b, and: a+b)
        }else{
            return a+b
        }
    }
    
    /// 水仙花数
    ///
    /// - Parameter index: 第几个
    /// - Returns: 数值
    func getFibonacciNum(at index:Int) ->Int {
        
        if index < 2 {
            return 1
        }
        return getFibonacciNum(at:index-1) + getFibonacciNum(at:index-2)
    }

}
