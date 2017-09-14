//
//  PointLineViewController.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/9/12.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit



class PointLineViewController: BaseViewController {
    // MARK: - 属性值private
    
    
    // MARK: - 对外接口
    
    // MARK: - 生命周期与复写
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - 界面布局
    func initView() {
        //
        view.backgroundColor = UIColor.white
        let v = PointLineView.init(frame: CGRect.init(x: 10, y: 10, width: view.width-20, height: 600))
        view.addSubview(v)
    }
    
    // MARK: - 功能函数
    
    
    // MARK: - 代理方法
    
    // MARK: - 其他

}
