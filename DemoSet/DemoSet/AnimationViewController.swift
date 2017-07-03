//
//  AnimationViewController.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/6/29.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit

class AnimationViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let leaf = LeafView.init(frame: CGRect.init(x: 20, y: 20, width: 70, height: 100))
        view.addSubview(leaf)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
