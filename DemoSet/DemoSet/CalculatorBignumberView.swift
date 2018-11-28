//
//  CalculatorBignumberView.swift
//  DemoSet
//
//  Created by 李世远 on 2018/11/12.
//  Copyright © 2018年 Far. All rights reserved.
//

import UIKit

class CalculatorBignumberView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView() {
        multiply()
    }
    
    
    /// 列式
    func multiply() {
        let num1 = "12345"
        let num2 = "7879"
        
        var line:[[Int]] = []
        for c in num1 {
            let n = Int(String(c))!
            var l:[Int] = []
            for c2 in num2 {
                let n2 = Int(String(c2))!
                l.append(n2*n)
            }
            line.append(l)
        }
        
        //
        var numlist:[Int] = []
        let inx = line.count
        for i in 0..<inx {
            let ll = line[i]
            for j in i..<ll.count+i {
                let n = ll[j-i]
                if j >= numlist.count {
                    numlist.append(n)
                }else{
                    numlist[j] = numlist[j] + n
                }
            }
        }
        //
        let cout = numlist.count
        var result:String = ""
        var add:Int = 0
        for i in 1...cout {
            var r = numlist[cout-i]
            r += add
            if r < 10 {
                result.insert(String(r).first!, at: String.Index.init(encodedOffset: 0))
            }else{
                let ss = r%10
                let sr = r/10
                add = sr
                result.insert(String(ss).first!, at: String.Index.init(encodedOffset: 0))
            }
        }
        print(result)
    }
    
    /// 乘法
    func karaTsuba() {
        
    }

}
