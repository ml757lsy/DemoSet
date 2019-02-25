//
//  AlertModule.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/9/16.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit

/// 弹窗模块
class AlertModule: NSObject {
    
    class func showAlert(title titleStr:String, conetent contentStr:String, from controller:UIViewController) {
    }
    
    class func showAlert(title titleStr:String, conetent contentStr:String, actionStr:[String], actions:@escaping (Int)->Void) {
        let alert = UIAlertController.init(title: titleStr, message: contentStr, preferredStyle: .alert)
        for i in 0..<actionStr.count {
            let action = UIAlertAction.init(title: actionStr[i], style: .default) { (action) in
                actions(i)
                alert.dismiss(animated: true, completion: {
                    //
                })
            }
            alert.addAction(action)
        }
        
        let controller = currentController()
        controller.present(alert, animated: true) {
            //
        }
    }
    
    /// 弹窗界面
    ///
    /// - Parameters:
    ///   - titleStr: 标题
    ///   - contentStr: 内容
    ///   - controller: 来自哪
    ///   - time: 持续时间
    ///   - complate: 完成的block
    class func showToast(title titleStr:String? = "", conetent contentStr:String? = "", from controller:UIViewController,duration time:CGFloat, animated:Bool = true, complate:@escaping ()->Void) {
        
        let alert = UIAlertController.init(title: "\(titleStr ?? "")", message: "\(contentStr ?? "")", preferredStyle: .alert)
        controller.present(alert, animated: animated) {
            //
        }
        
        perform(#selector(AlertModule.complate(with:)), with: ["alert":alert,"block":complate,"animated":animated], afterDelay: TimeInterval(time))
    }
    
    /// 弹窗界面
    ///
    /// - Parameters:
    ///   - titleStr: 标题
    ///   - contentStr: 内容
    ///   - time: 持续时间
    ///   - complate: 完成block
    class func showToast(title titleStr:String? = "", conetent contentStr:String? = "", duration time:CGFloat, complate:@escaping ()->Void) {
        let controller = currentController()
        showToast(title: titleStr, conetent: contentStr, from: controller, duration: time, complate: complate)
    }
    
    class func showWaitToast(titleStr:String? = "",duration time:CGFloat, complate:@escaping ()->Void) {
        let controller = currentController()
        let alert = UIAlertController.init(title: "\(titleStr ?? "")", message: " \n  \n", preferredStyle: .alert)
        
//
        let activity = UIActivityIndicatorView.init(style: .gray)
        activity.frame = CGRect.init(x: 0, y: 0, width: SCREENWIDTH*0.72, height: 120)
        activity.startAnimating()
        alert.view.addSubview(activity)
        
        controller.present(alert, animated: true) {
            //
        }
        
        perform(#selector(AlertModule.complate(with:)), with: ["alert":alert,"block":complate,"animated":true], afterDelay: TimeInterval(time))
    }
    
    @objc class func complate(with info:[String:Any]){
        let toast = info["alert"] as! UIAlertController
        let block = info["block"] as! ()->Void
        let animated = info["animated"] as! Bool
        toast.dismiss(animated: animated) {
            block()
        }
    }
    
    /// 当前界面的controller
    ///
    /// - Returns: controller
    class func currentController() -> UIViewController {
        var result:UIViewController = UIViewController()
        var window = UIApplication.shared.keyWindow
        if (window?.windowLevel != UIWindow.Level.normal)
        {
            let windows = UIApplication.shared.windows
            for tmpWin in windows{
                if (tmpWin.windowLevel == UIWindow.Level.normal){
                    window = tmpWin
                    break
                }
            }
        }
        
        let frontView = window?.subviews.first
        let nextResponder = frontView?.next

        if (nextResponder?.isKind(of: UIViewController.self))!{
            result = nextResponder as! UIViewController;
        }else{
            result = (window?.rootViewController)!
        }
        
        return result
    }

}
