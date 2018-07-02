//
//  SlideMenuViewController.swift
//  DemoSet
//
//  Created by 李世远 on 2018/6/28.
//  Copyright © 2018年 Far. All rights reserved.
//

import UIKit

public struct SlideMenuOptions {
    static let leftViewWidth:CGFloat = 270
    static let opacityViewBackgroundColor = UIColor.init(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.2)
}

class SlideMenuViewController: BaseViewController {
    
    private var left:UIViewController = UIViewController()
    private var main:UIViewController = UIViewController()
    var leftView:UIView = UIView()
    var mainView:UIView = UIView()
    var opacityView:UIView = UIView()
    
    var leftController:UIViewController {
        get{
            return left
        }
        set(newVlaue) {
            left = newVlaue
            left.view.frame = leftView.bounds
            if !self.childViewControllers.contains(newVlaue) {
                addChildViewController(left)
                leftView.addSubview(left.view)
                left.didMove(toParentViewController: self)
            }
            //
        }
    }
    
    var mainController:UIViewController {
        get{
            return main
        }
        set(newVlaue) {
            main = newVlaue
            main.view.frame = mainView.bounds
            
            if self.childViewControllers.contains(newVlaue) {
                addChildViewController(main)
                mainView.addSubview(main.view)
                main.didMove(toParentViewController: self)
            }
        }
    }
    
    /// 创建
    ///
    /// - Parameters:
    ///   - leftViewController: menu
    ///   - mainViewController: main
    public convenience init(leftViewController:UIViewController, mainViewController:UIViewController) {
        self.init()
        mainController = mainViewController
        leftController = leftViewController
        initView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView() {
        mainView = UIView(frame: view.bounds)
        mainView.backgroundColor = UIColor.clear
        mainView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        view.insertSubview(mainView, at: 0)
        
        var opacityframe: CGRect = view.bounds
        let opacityOffset: CGFloat = 0
        opacityframe.origin.y = opacityframe.origin.y + opacityOffset
        opacityframe.size.height = opacityframe.size.height - opacityOffset
        opacityView = UIView(frame: opacityframe)
        opacityView.backgroundColor = SlideMenuOptions.opacityViewBackgroundColor
        opacityView.autoresizingMask = [UIViewAutoresizing.flexibleHeight, UIViewAutoresizing.flexibleWidth]
        opacityView.layer.opacity = 0.0
        view.insertSubview(opacityView, at: 1)
        
        if leftController != nil {
            var leftFrame: CGRect = view.bounds
            leftFrame.size.width = SlideMenuOptions.leftViewWidth
            leftFrame.origin.x = -SlideMenuOptions.leftViewWidth
            let leftOffset: CGFloat = 0
            leftFrame.origin.y = leftFrame.origin.y + leftOffset
            leftFrame.size.height = leftFrame.size.height - leftOffset
            leftView = UIView(frame: leftFrame)
            leftView.backgroundColor = UIColor.yellow
            leftView.autoresizingMask = UIViewAutoresizing.flexibleHeight
            view.insertSubview(leftView, at: 2)
//            addLeftGestures()
        }
        
    }
    
    func openLeft() {
        left.beginAppearanceTransition(true, animated: true)
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseInOut, animations: {
            //
            self.leftView.x = 0
            self.mainView.x = SlideMenuOptions.leftViewWidth
        }) { (complate) in
            //
        }
    }
    
    func closeLeft() {
        
    }

}

extension UIViewController {
    
    /// 获取控制器
    ///
    /// - Returns: 控制器
    func slideMenuController() -> SlideMenuViewController? {
        var viewcontroller:UIViewController? = self
        while viewcontroller != nil {
            if viewcontroller is SlideMenuViewController{
                return viewcontroller as? SlideMenuViewController
            }
            viewcontroller = viewcontroller?.parent
        }
        
        return nil
    }
}
