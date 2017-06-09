//
//  ViewController.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/6/9.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        perform(#selector(toCell), with: nil, afterDelay: 1)
    }
    
    func toCell() {
        let cell = CellularAutomatonViewController()
        present(cell, animated: true) { 
            //
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

