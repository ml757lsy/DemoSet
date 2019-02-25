//
//  I18NViewController.swift
//  DemoSet
//
//  Created by 李世远 on 2018/5/28.
//  Copyright © 2018年 Far. All rights reserved.
//

import UIKit

class I18NViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView() {
        let b = UIButton.init(type: .custom)
        b.frame = CGRect.init(x: 20, y: 20, width: 100, height: 40)
        b.setTitle("Change", for: .normal)
        b.setTitleColor(UIColor.orange, for: .normal)
        b.addTarget(self, action: #selector(changeLanguage), for: .touchUpInside)
        
        let c = UIButton.init(type: .custom)
        c.frame = CGRect.init(x: 0, y: 0, width: 40, height: 40)
        c.setTitle("Clean", for: .normal)
        c.setTitleColor(UIColor.red, for: .normal)
        c.addTarget(self, action: #selector(cleanView), for: .touchUpInside)
        navigationItem.rightBarButtonItems = [UIBarButtonItem.init(customView: c),UIBarButtonItem.init(customView: b)]
        
        
        let l = UILabel.init(frame: CGRect.init(x: 20, y: 80, width: view.width-40, height: 40))
        view.addSubview(l)
        l.I18NLocalized(key: "FGO")
        
        let button = UIButton.init(type: .custom)
        view.addSubview(button)
        button.frame = CGRect.init(x: 20, y: 150, width: 100, height: 40)
        button.setTitleColor(UIColor.red, for: .normal)
        button.I18NLocalized(key: "Math", state: .normal)
        button.setTitleColor(UIColor.blue, for: .highlighted)
        button.I18NLocalized(key: "Sort", state: .highlighted)
        button.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
    }
    
    @objc func cleanView() {
        for v in view.subviews {
            v.removeFromSuperview()
        }
        //清除后控件不会接收到通知 goodjob
        AlertModule.showToast(title: "提示", conetent: "清除完成", duration: 1) {
            //
        }
    }
    
    @objc func buttonClick() {
        
    }
    
    @objc func changeLanguage() {
        let languages = I18NManager.manager.suportLanguagesString
        AlertModule.showAlert(title: "更改语言", conetent: "选择更改的语言", actionStr: languages) { (i) in
            I18NManager.manager.setLanguageIndex(index: i)
            //加2秒的设置时间，弹窗阻隔一下
            AlertModule.showWaitToast(titleStr: "设置中...", duration: 1.5, complate: {
                //
                AlertModule.showToast(title: "", conetent: "设置完成", duration: 0.3, complate: {
                    //
                })
            })
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
