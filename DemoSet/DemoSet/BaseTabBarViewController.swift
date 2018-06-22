//
//  BaseTabBarViewController.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/12/6.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit

class BaseTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        //动画特效
        
        
        switch item.tag {
        case 1:
            //
            break
        case 2:
            let url = URL.init(fileURLWithPath: Bundle.main.path(forResource: "testGif2", ofType: "gif", inDirectory: nil)!)
            item.image = UIImage.loadgif(url: url)
            break
        default:
            break
        }
        
        return
        
        for sub in tabBar.subviews {
            if sub.isUserInteractionEnabled {
                for s in sub.subviews {
                    if s.isKind(of: NSClassFromString("UITabBarSwappableImageView")!) {
                        let ss = s as! UIImageView
                        ss.animationRepeatCount = 1
                    }
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
