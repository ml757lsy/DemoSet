//
//  AppStoreContentView.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/12/5.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit

class AppStoreContentViewController: BaseViewController {

    var closeBlock:()->Void = {}
    
    private var _fromeFrame:CGRect = CGRect.zero
    
    var fromFrame:CGRect{
        get {
            return _fromeFrame
        }
        set(newValue) {
            _fromeFrame = newValue
            content.frame = newValue
        }
    }
    
    var content:UIView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        
        let blur = UIBlurEffect.init(style: .regular)
        let bg = UIVisualEffectView.init(effect: blur)
        bg.frame = view.frame
        view.addSubview(bg)
        
        content.frame = fromFrame
        content.layer.cornerRadius = 10
        content.clipsToBounds = true
        view.addSubview(content)
        
        
        let close = UIButton.init(type: .custom)
        view.addSubview(close)
        close.frame = CGRect.init(x: SCREENWIDTH-40, y: 10, width: 20, height: 20)
        close.setTitle("X", for: .normal)
        close.setTitleColor(UIColor.red, for: .normal)
        close.addTarget(self, action: #selector(closeClick), for: .touchUpInside)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showAnimation()
    }
    
    func showAnimation() {
        UIView.animate(withDuration: 0.4) {
            self.content.frame = self.view.frame
            self.content.layer.cornerRadius = 0
        }
    }
    
    func closeAnimation() {
        UIView.animate(withDuration: 0.4, animations: {
            self.closeBlock()
            self.content.frame = self.fromFrame
            self.content.layer.cornerRadius = 10
        }) { (b) in
            self.dismiss(animated: false, completion: {
                //
            })
        }
    }
    
    func closeClick() {
        closeAnimation()
    }

}
