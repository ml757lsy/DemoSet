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
        
        //
        let PalindromeNum = UIButton.init(type: .custom)
        PalindromeNum.frame = CGRect.init(x: 120, y: 60, width: 100, height: 40)
        PalindromeNum.setTitle("Palindrome", for: .normal)
        PalindromeNum.setTitleColor(UIColor.orange, for: .normal)
        PalindromeNum.addTarget(self, action: #selector(PalindromeNumClick), for: .touchUpInside)
        view.addSubview(PalindromeNum)
        
        //
        let binarytree = UIButton.init(type: .custom)
        binarytree.frame = CGRect.init(x: 240, y: 60, width: 100, height: 40)
        binarytree.setTitle("BinaryTree", for: .normal)
        binarytree.setTitleColor(UIColor.orange, for: .normal)
        binarytree.addTarget(self, action: #selector(binaryTreeClick), for: .touchUpInside)
        view.addSubview(binarytree)
        
        //
        
        let l = UIBezierPath.init()
        l.move(to: CGPoint.init(x: 100, y: 100))
        l.addLine(to: CGPoint.init(x: 200, y: 200))
        l.addLine(to: CGPoint.init(x: 100, y: 300))
        
        let shap = CAShapeLayer.init()
        shap.path = l.cgPath
        shap.fillColor = UIColor.red.cgColor
        shap.opacity = 0.8
        view.layer.addSublayer(shap)
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
    
    
    //
    func PalindromeNumClick() {
        let alert = UIAlertController.init(title: "", message: "输入初始数字", preferredStyle: .alert)
        
        alert.addTextField { (textfiled) in
        }
        
        let commit = UIAlertAction.init(title: "ji", style: .default) { (action) in
            if (alert.textFields?.count)! > 0 {
                let text = alert.textFields![0]
                self.palindrimeNumComit(num: text.text!,time: 1)
            }
            
            alert.dismiss(animated: true, completion: {
                //
            })
        }
        
        alert.addAction(commit)
        
        present(alert, animated: true) {
            //
        }
    }
    
    func palindrimeNumComit(num:String, time:Int){
        
        let seriation = num as NSString
        var count:String = ""
        
        var add:Int = 0
        for i in 0..<seriation.length {
            let c1 = seriation.character(at: i) - 48
            let c2 = seriation.character(at: seriation.length-1-i) - 48
            
            var c = c1 + c2 + add
            if c >= 10 {
                c -= 10
                add = 1
            }else{
                add = 0
            }
            count = "\(c)"+count
        }
        
        if add == 1{
            count = "1"+count
            add = 0
        }
        
        if checkPalindrime(num: count) {

            let alert = UIAlertController.init(title: "成功", message: "回文数字为"+count+"\n\(time)次计算", preferredStyle: .alert)
            present(alert, animated: true, completion: {
                //
            })
            let close = UIAlertAction.init(title: "确定", style: .default, handler: { (action) in
                alert.dismiss(animated: true, completion: {
                    //
                })
            })
            alert.addAction(close)
        }else{
            print(count+" not Palindrime")
            palindrimeNumComit(num: count,time: time+1)
        }
        
        
    }
    
    func checkPalindrime(num:String) -> Bool {
        let numstring = num as NSString
        let count = numstring.length
        for i in 0..<count {
            let c1 = numstring.character(at: i)
            let c2 = numstring.character(at: count-1-i)
            if c1 != c2 {
                return false
            }
        }
        
        return true
    }
    
    //
    func binaryTreeClick() {
        let bin = BinaryTreeViewController()
        navigationController?.pushViewController(bin, animated: true)
    }

}
