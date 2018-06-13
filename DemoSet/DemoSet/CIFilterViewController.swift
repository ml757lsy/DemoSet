//
//  CIFilterViewController.swift
//  DemoSet
//
//  Created by 李世远 on 2018/6/13.
//  Copyright © 2018年 Far. All rights reserved.
//

import UIKit

class CIFilterViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let names = CIFilter.filterNames(inCategory: nil)
        print(names)
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
