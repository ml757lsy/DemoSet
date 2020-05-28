//
//  LocalAuthenticationViewController.swift
//  DemoSet
//
//  Created by 李世远 on 2019/3/26.
//  Copyright © 2019 Far. All rights reserved.
//

import UIKit
import LocalAuthentication

class LocalAuthenticationViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let button = UIButton.init(type: .system)
        button.frame = CGRect.init(x: 10, y: 100, width: 100, height: 40)
        button.setTitle("Auth", for: .normal)
        button.addTarget(self, action: #selector(Auth), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc func Auth() {
        let context = LAContext.init()
        let error = NSErrorPointer.init(nilLiteral: ())
        let type = LAPolicy.deviceOwnerAuthenticationWithBiometrics
        let des = "需要看脸"
        if (context.canEvaluatePolicy(type, error: error)) {
            //
            context.evaluatePolicy(type, localizedReason: des) {
             (b, e) in
                //
                if (b) {
                    AlertModule.showAlert(title: "刷脸", conetent: "是你呢", from: self)
                }else{
                    let err = e! as NSError
                    switch (err.code) { //认证策略，error
                    case -1:
                        print("---- kLAErrorAuthenticationFailed （超出app重试限制（连续3次））")
                        break
                    case -2:
                        print("---- kLAErrorUserCancel （点击了取消按钮）")
                        break
                    case -3:
                        print("---- kLAErrorUserFallback (点击输入密码按钮)");
                        break
                    case -4:
                        print("---- kLAErrorSystemCancel (应用进入后台，如按下电源键或来电等切换到其他应用)")
                        break
                    case -7:
                        print("---- kLAErrorTouchIDNotEnrolled (身份验证无法启动，因为Touch ID没有注册的手指。)")
                        break
                    case -8:
                        print("---- kLAErrorTouchIDLockout （Touch ID 功能被锁定，下一次需要输入系统密码）")
                        break
                    case -9:
                        print("---- kLAErrorAppCancel (认证被取消的应用)")
                        break
                    case -10:
                        print("---- kLAErrorInvalidContext ")
                        break
                    default:
                        break
                        
                    }
                    print("---- Touch ID指纹验证失败 ----- \n 错误信息：error = \(String(describing: e))")
                }
            }
        }else {
            print(error?.debugDescription as Any)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
