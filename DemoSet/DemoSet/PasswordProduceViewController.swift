//
//  PasswordProduceViewController.swift
//  DemoSet
//
//  Created by lishiyuan on 2018/5/22.
//  Copyright © 2018年 Far. All rights reserved.
//

import UIKit

class PasswordProduceViewController: BaseViewController {
    
    let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        initPPView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func initPPView() {
        let creat = UIButton.init(type: .system)
        view.addSubview(creat)
        creat.setTitle("Creat", for: .normal)
        creat.frame = CGRect.init(x: 20, y: 20, width: 100, height: 40)
        creat.addTarget(self, action: #selector(passwordProduce), for: .touchUpInside)
        
        view.addSubview(label)
        label.textAlignment = .center
        label.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(150)
            make.right.equalTo(-10)
            make.height.equalTo(40)
        }
    }
    
    func passwordProduce() {
        label.text = PasswordProduceManager.manager.producePureNumWith(length: 6)
    }

}
