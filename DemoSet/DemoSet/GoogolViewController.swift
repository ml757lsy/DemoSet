//
//  GoogolViewController.swift
//  DemoSet
//
//  Created by 李世远 on 2019/1/24.
//  Copyright © 2019 Far. All rights reserved.
//

import UIKit

/// 大数计算
class GoogolViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let a = "11231231231231231214214121"
        let b = "212344555507902798897788"
        let c = a.multiply(rhs: b)
        let d = a.add(rhs: b)
//        let e = a.divid(rhs: b, multiply: 10)
        print("Multiply\(c)")
        print("Add\(d)")
//        print("Minus\(e)")
        
        let f = "000-0123.456.789"
        print("Goo\(f.googolString())")
        
        let g = "123(123)(2)"
        print("Fom\(g.fistC())")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}
