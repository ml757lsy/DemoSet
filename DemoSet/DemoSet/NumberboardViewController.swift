//
//  NumberboardViewController.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/6/16.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit

class NumberboardViewController: UIViewController {
    // MARK: - 属性值private
    
    // MARK: - 对外接口
    
    // MARK: - 生命周期与复写
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNumberview()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - 界面布局
    func initNumberview() {
        view.backgroundColor = UIColor.white
        
        let numberboard = Numberboard()
        numberboard.frame = CGRect.init(x: 20, y: 100, width: 400, height: 80)
        view.addSubview(numberboard)
        numberboard.number = -1234.5678
        numberboard.backgroundColor = UIColor.green
        
    }
    
    // MARK: - 功能函数
    
    func chikk() {
        var kids:[Kid] = []
        var week:[Int] = [0,0,0,0,0,0,0]
        var kidsex:[Int] = [0,0]
        for i in 0..<500000 {
            let w1 = Int(arc4random()%7)
            let w2 = Int(arc4random()%7)
            let k1 = Int(arc4random()%2)
            let k2 = Int(arc4random()%2)
            let kid = Kid.init(week1: w1, kid1: k1, week2: w2, kid2: k2)
            
            week[w1] += 1
            week[w2] += 1
            
            kidsex[k1] += 1
            kidsex[k2] += 1
            
            kids.append(kid)
        }
        
        print(week)
        print(kidsex)
        
        var last21:Int = 0
        var other:Int = 0
        
        for kid in kids {
            if (kid.week1 == 2 && kid.kid1 == 1){
                last21 += 1
                if (kid.kid2 == 1){
                    other += 1
                }
            }else if (kid.week2 == 2 && kid.kid2 == 1){
                last21 += 1
                if (kid.kid1 == 1){
                    other += 1
                }
            }
        }
        print(last21)
        print(other)
        
        let min:CGFloat = CGFloat(last21)*0.45
        let max = CGFloat(last21)/2
        let datap = (CGFloat(other)-min)/(max-min)
        let signp = (CGFloat(last21)*13/27-min)/(max-min)
        
        let bg = UIView.init(frame: CGRect.init(x: 10, y: 200, width: 360, height: 4))
        bg.backgroundColor = UIColor.lightGray
        view.addSubview(bg)
        
        let sign = UIView.init(frame: CGRect.init(x: 360*signp, y: 0, width: 1, height: 4))
        sign.backgroundColor = UIColor.red
        bg.addSubview(sign)
        
        let data = UIView.init(frame: CGRect.init(x: 360*datap, y: 0, width: 1, height: 4))
        data.backgroundColor = UIColor.green
        bg.addSubview(data)
        
    }
    
    // MARK: - 代理方法
    
    // MARK: - 其他

}

struct Kid {
    var week1:Int = 0
    var kid1:Int = 0
    var week2:Int = 0
    var kid2:Int = 0
}
