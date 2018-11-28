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
    private var blurBack:UIVisualEffectView = UIVisualEffectView()
    
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
    var close:UIButton = UIButton.init(type: .custom)
    private var _model:AppStoreContentModel = AppStoreContentModel()
    var model:AppStoreContentModel{
        get{
            return _model
        }
        set(newValue) {
            _model = newValue
            content.backgroundColor = _model.color
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        
        //
        let blur = UIBlurEffect.init(style: .regular)
        blurBack = UIVisualEffectView.init(effect: blur)
        blurBack.alpha = 0.2
        blurBack.frame = view.bounds
        view.addSubview(blurBack)
        
        //
        content.frame = fromFrame
        content.layer.cornerRadius = 10
        content.clipsToBounds = true
        view.addSubview(content)
        
        
        content.addSubview(close)
        close.frame = CGRect.init(x: content.width-20-30, y: 20+40, width: 30, height: 30)
        close.setTitle("X", for: .normal)
        close.backgroundColor = UIColor.white
        close.setTitleColor(UIColor.red, for: .normal)
        close.layer.cornerRadius = 15
        close.alpha = 0.2
        close.addTarget(self, action: #selector(closeClick), for: .touchUpInside)
        
        let sign = UIView()
        sign.frame = CGRect.init(x: 20, y: 100, width: 100, height: 100)
        content.addSubview(sign)
        sign.backgroundColor = UIColor.randomColor()
        
        //
        let drag = UIPanGestureRecognizer.init(target: self, action: #selector(dragclose(pan:)))
        content.addGestureRecognizer(drag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showAnimation()
    }
    
    // MARK: - animation
    func showAnimation() {
        UIView.animate(withDuration: 0.4, animations: {
            self.content.frame = CGRect.init(x: -5, y: -5, width: self.view.width+10, height: self.view.height+10)
            self.content.layer.cornerRadius = 0
            self.close.frame = CGRect.init(x: self.content.width-20-30, y: 20+40, width: 30, height: 30)
            self.close.alpha = 0.9
        }) { (t) in
            UIView.animate(withDuration: 0.2, animations: {
                self.content.frame = self.view.bounds
                self.content.layer.cornerRadius = 0
                self.close.frame = CGRect.init(x: self.content.width-20-30, y: 20+40, width: 30, height: 30)
                self.close.alpha = 1
            })
        }
    }
    
    func closeAnimation() {
        blurBack.alpha = 0
        UIView.animate(withDuration: 0.4, animations: {
            self.closeBlock()
            self.content.frame = self.fromFrame
            self.content.layer.cornerRadius = 10
            self.close.frame = CGRect.init(x: self.content.width-20-30, y: 20+40, width: 30, height: 30)
            self.close.alpha = 0.2
            self.blurBack.alpha = 0.5
        }) { (b) in
            self.dismiss(animated: false, completion: {
            })
        }
    }
    
    //MARK: - func
    func closeClick() {
        closeAnimation()
    }
    
    
    func dragclose(pan:UIPanGestureRecognizer) {
        if pan.state == .began {
            //start
            pan.location(in: content)
            content.frame = fromFrame
        }
        print(pan.location(in: content))
    }

}
