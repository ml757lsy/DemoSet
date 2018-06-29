//
//  SlideMenuViewController.swift
//  DemoSet
//
//  Created by 李世远 on 2018/6/28.
//  Copyright © 2018年 Far. All rights reserved.
//

import UIKit

class SlideMenuViewController: BaseViewController {
    
    var left:UIViewController = UIViewController()
    var right:UIViewController = UIViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        addChildViewController(left)
        addChildViewController(right)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showLeft() {
        left.beginAppearanceTransition(true, animated: true)
    }
    
    func hidenLeft() {
        
    }

}
