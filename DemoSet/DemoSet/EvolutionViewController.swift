//
//  EvolutionViewController.swift
//  DemoSet
//
//  Created by lishiyuan on 2018/5/21.
//  Copyright © 2018年 Far. All rights reserved.
//

import UIKit

class EvolutionViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        initEvolutionView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func initEvolutionView() {
        
    }
    
    func initGod() {
        let god = EvolutionGod.god
        god.creatWorldwith(cellnum: 100, groundwidth: 100, height: 100, size: 1)
    }
}
