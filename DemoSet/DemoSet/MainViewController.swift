//
//  MainViewController.swift
//  DemoSet
//
//  Created by 李世远 on 2018/6/28.
//  Copyright © 2018年 Far. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func baseinit() {
        print("123")
        let show = UIButton.init(type: .system)
        show.setTitle("Menu", for: .normal)
        show.frame = CGRect.init(x: 0, y: 0, width: 44, height: 44)
        show.addTarget(self, action: #selector(showLeft), for: .touchUpInside)
        
        let right = UIBarButtonItem.init(customView: show)
        navigationItem.rightBarButtonItem = right
        
        view.backgroundColor = UIColor.blue
    }
    
    func showLeft() {
        let slide = self.slideMenuController()
        slide?.openLeft()
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
