//
//  SlideMenuViewController.swift
//  DemoSet
//
//  Created by 李世远 on 2018/6/28.
//  Copyright © 2018年 Far. All rights reserved.
//

import UIKit

public struct SlideMenuOption {
    static let leftMenuWidth:CGFloat = 270
}

class SlideMenuViewController: BaseViewController {
    
    var left:UIViewController = UIViewController()
    var main:UIViewController = UIViewController()
    var leftView:UIView = UIView()
    var mainView:UIView = UIView()
    
    var leftController:UIViewController {
        get{
            return left
        }
        set(newVlaue) {
            left.removeFromParentViewController()
            
            left = newVlaue
            leftView.addSubview(left.view)
            leftView.frame = leftView.bounds
            //
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func openLeft() {
        left.beginAppearanceTransition(true, animated: true)
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseInOut, animations: {
            //
            self.leftView.x = 0
            self.mainView.x = SlideMenuOption.leftMenuWidth
        }) { (complate) in
            //
        }
    }
    
    func closeLeft() {
        
    }

}
