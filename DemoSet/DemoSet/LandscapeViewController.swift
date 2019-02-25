//
//  LandscapeViewController.swift
//  DemoSet
//
//  Created by 李世远 on 2018/6/21.
//  Copyright © 2018年 Far. All rights reserved.
//

import UIKit

class LandscapeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let button = UIButton.init(frame: CGRect.init(x: 20, y: 20, width: 60, height: 30))
        view.addSubview(button)
        button.setTitle("Jump", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.addTarget(self, action: #selector(jump), for: .touchUpInside)
        
        let sign = UIView.init(frame: CGRect.init(x: 20, y: 60, width: view.frame.size.width-40, height: 40))
        sign.backgroundColor = UIColor.red
        view.addSubview(sign)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func jump() {
        let land = LandAimViewController()
        let landv = UINavigationController.init(rootViewController: land)
        present(landv, animated: true) {
            //
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
