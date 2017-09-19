//
//  WaveViewController.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/9/19.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit

class WaveViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let wave = WaveView.init(frame: CGRect.init(x: 10, y: 10, width: view.width-20, height: 300))
        view.addSubview(wave)
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
