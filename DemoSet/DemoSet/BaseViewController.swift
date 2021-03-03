//
//  BaseViewController.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/6/13.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        edgesForExtendedLayout = .init(rawValue: 0)
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if event?.subtype == UIEvent.EventSubtype.motionShake && event?.type == UIEvent.EventType.motion {
            AlertModule.showAlert(title: "Tool", conetent: "", actionStr: ["设置","FLEX"]) { (index) in
                if index == 0 {
                    //设置
                }else if index == 1 {
                    //flex
                    FLEXManager.shared().showExplorer()
                }
            }
        }
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
