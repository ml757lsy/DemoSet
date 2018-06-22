//
//  BaseNavigationViewController.swift
//  DemoSet
//
//  Created by 李世远 on 2018/6/21.
//  Copyright © 2018年 Far. All rights reserved.
//

import UIKit

class BaseNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if self.topViewController != nil {
            return (topViewController?.supportedInterfaceOrientations)!
        }
        return super.supportedInterfaceOrientations
    }

}
