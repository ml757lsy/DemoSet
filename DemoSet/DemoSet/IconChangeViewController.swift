//
//  IconChangeViewController.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/7/14.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit

class IconChangeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.orange
        // Do any additional setup after loading the view.
        let button = UIButton.init(frame: CGRect.init(x: 30, y: 30, width: 100, height: 40))
        button.setTitle("图标转变", for: .normal)
        button.setImage(UIImage.init(named: ""), for: .normal)
        view.addSubview(button)
        button.addTarget(self, action: #selector(changeIcon), for: .touchUpInside)
        
        let imageView = UIImageView.init(frame: CGRect.init(x: 30, y: 100, width: 100, height: 100))
        imageView.image = UIImage.init(named: "testImage")
        view.addSubview(imageView)
        
        let c = imageView.reflection()
        c.frame = CGRect.init(x: 30, y: 200, width: 100, height: 100)
        c.y = 200
        view.addSubview(c)
    }
    
    func changeIcon() {
        if #available(iOS 10.3, *) {
            if UIApplication.shared.supportsAlternateIcons {
                //
                UIApplication.shared.setAlternateIconName("AppIcon2", completionHandler: { (error) in
                    print(error)
                })
            }
        } else {
            // Fallback on earlier versions
            print("iOS 10.3 or later")
        }
        
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
