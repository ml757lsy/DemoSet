//
//  LandAimViewController.swift
//  DemoSet
//
//  Created by 李世远 on 2018/6/21.
//  Copyright © 2018年 Far. All rights reserved.
//

import UIKit

class LandAimViewController: BaseViewController {

    private var _orientation = UIInterfaceOrientationMask.landscape
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.randomColor()
//        UIApplication.shared.setStatusBarOrientation(.landscapeRight, animated: false)
        
        let x = UILabel.init(frame: CGRect.init(x: 20, y: 20, width: 300, height: 20))
        view.addSubview(x)
        x.text = "123141234kjadsljakljiqwojeiojwnmdlkmqiojwio"
        
        let back = UIButton.init(frame: CGRect.init(x: 20, y: 100, width: 60, height: 30))
        back.setTitle("BACK", for: .normal)
        back.setTitleColor(UIColor.black, for: .normal)
        back.addTarget(self, action: #selector(dismissSelf), for: .touchUpInside)
        view.addSubview(back)
        
        let t1 = UIButton.init(frame: CGRect.init(x: 600, y: 100, width: 60, height: 30))
        t1.setTitle("T1", for: .normal)
        t1.setTitleColor(UIColor.black, for: .normal)
        t1.tag = 100
        t1.addTarget(self, action: #selector(buttonClick(button:)), for: .touchUpInside)
        view.addSubview(t1)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return _orientation
        }
        set(newvalue) {
            _orientation = newvalue
        }
    }
    
    @objc func dismissSelf() {
        self.dismiss(animated: true) {
            //
        }
    }
    
    @objc func buttonClick(button:UIButton) {
        print(button.tag)
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
