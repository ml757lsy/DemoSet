//
//  NotificationViewController.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/9/14.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit

class NotificationViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView() {
        let addbutton = UIButton.init(type: .system)
        addbutton.frame = CGRect.init(x: 10, y: 40, width: 60, height: 40)
        addbutton.setTitle("Add", for: .normal)
        addbutton.addTarget(self, action: #selector(localNotification), for: .touchUpInside)
        view.addSubview(addbutton)
        
        let removebutton = UIButton.init(type: .system)
        removebutton.frame = CGRect.init(x: 100, y: 40, width: 60, height: 40)
        removebutton.setTitle("Remove", for: .normal)
        removebutton.addTarget(self, action: #selector(removeNoti), for: .touchUpInside)
        view.addSubview(removebutton)
    }
    
    func removeNoti() {
        NotificationModule.manager.removeNotification()
    }
    
    func localNotification() {
        NotificationModule.manager.addLocalNotification()
    }

}
