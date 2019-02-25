//
//  AppStoreContentView.swift
//  DemoSet
//
//  Created by 李世远 on 2018/6/22.
//  Copyright © 2018年 Far. All rights reserved.
//

import UIKit

class AppStoreContentView: UIView {

    private var _fromFrame:CGRect = CGRect.zero
    private var _model:AppStoreContentModel = AppStoreContentModel()
    private var _content:UIView = UIView()
    private let close:UIButton = UIButton.init(type: .custom)
    
    var fromFrame:CGRect{
        get {
            return _fromFrame
        }
        set(newValue) {
            _fromFrame = newValue
            _content.frame = _fromFrame
        }
    }
    
    var model:AppStoreContentModel {
        get {
            return _model
        }
        set(newValue) {
            _model = newValue
            _content.backgroundColor = _model.color
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        baseInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func baseInit() {
        let blur = UIBlurEffect.init(style: .regular)
        let blurBack = UIVisualEffectView.init(effect: blur)
        blurBack.alpha = 0.4
        blurBack.frame = bounds
        addSubview(blurBack)
        
        addSubview(_content)
        
        _content.addSubview(close)
        close.frame = CGRect.init(x: _content.width-20-30, y: 20+40, width: 30, height: 30)
        close.setTitle("X", for: .normal)
        close.backgroundColor = UIColor.white
        close.setTitleColor(UIColor.red, for: .normal)
        close.layer.cornerRadius = 15
        close.alpha = 0.2
        close.addTarget(self, action: #selector(closeAnimation), for: .touchUpInside)
        
        let test = UIButton.init(frame: CGRect.init(x: 0, y: SCREENHEIGHT-200, width: 100, height: 40))
        test.backgroundColor = UIColor.red
        test.addTarget(self, action: #selector(testClick), for: .touchUpInside)
        _content.addSubview(test)
    }
    
    @objc func testClick() {
        print("2123")
    }
    
    func showAnimation() {
        UIView.animate(withDuration: 0.4) {
            self._content.frame = self.bounds
            self.close.frame = CGRect.init(x: self._content.width-20-30, y: 20+40, width: 30, height: 30)
            self.close.alpha = 1
        }
    }
    
    @objc func closeAnimation() {
        UIView.animate(withDuration: 0.4, animations: {
            self._content.frame = self.fromFrame
            self.close.frame = CGRect.init(x: self._content.width-20-30, y: 20+40, width: 30, height: 30)
            self.close.alpha = 0.2
        }) { (t) in
            self.isHidden = true
        }
    }

}
