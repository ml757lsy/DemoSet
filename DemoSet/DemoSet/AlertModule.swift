//
//  AlertModule.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/9/16.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit

class AlertModule: NSObject {
    
    class func showAlert(title titleStr:String, conetent contentStr:String, from controller:UIViewController) {
    }
    
    class func showToast(title titleStr:String? = "", conetent contentStr:String? = "", from controller:UIViewController,duration time:CGFloat, complate:@escaping ()->Void) {
        
        let alert = UIAlertController.init(title: "\(titleStr ?? "")", message: "\(contentStr ?? "")", preferredStyle: .alert)
        controller.present(alert, animated: true) {
            //
        }
        
        perform(#selector(AlertModule.complate(with:)), with: ["alert":alert,"block":complate], afterDelay: TimeInterval(time))
    }
    
    class func complate(with info:[String:Any]){
        let toast = info["alert"] as! UIAlertController
        let block = info["block"] as! ()->Void
        toast.dismiss(animated: true) {
            block()
        }
    }
    
    class func currentController() -> UIViewController {
        var result:UIViewController = UIViewController()
        var window = UIApplication.shared.keyWindow
        if (window?.windowLevel != UIWindowLevelNormal)
        {
            let windows = UIApplication.shared.windows
            for tmpWin in windows{
                if (tmpWin.windowLevel == UIWindowLevelNormal){
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
