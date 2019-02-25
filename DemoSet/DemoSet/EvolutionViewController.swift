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
        let creatButton = UIButton.init(type: .system)
        view.addSubview(creatButton)
        creatButton.frame = CGRect.init(x: 10, y: 20, width: view.frame.size.width/2, height: 40)
        creatButton.setTitle("Create!", for: .normal)
        creatButton.addTarget(self, action: #selector(initGod), for: .touchUpInside)
        
        let stopButton = UIButton.init(type: .system)
        view.addSubview(stopButton)
        stopButton.frame = CGRect.init(x: view.frame.size.width/2, y: 20, width: view.frame.size.width/2, height: 40)
        stopButton.setTitle("Stop!", for: .normal)
        stopButton.addTarget(self, action: #selector(stopWorld), for: .touchUpInside)
    }
    
    @objc func initGod() {
        let god = EvolutionGod.god
        god.creatWorldwith(cellnum: 1, groundwidth: 100, height: 100, size: 1)
        god.startEvolution()
    }
    
    @objc func stopWorld() {
        EvolutionGod.god.stopEvolution()
    }
}
