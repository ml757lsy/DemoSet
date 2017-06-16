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
    
    // MARK: - 代理方法
    
    // MARK: - 其他

}
