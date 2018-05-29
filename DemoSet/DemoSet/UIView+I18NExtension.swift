//
//  UIView+I18NExtension.swift
//  DemoSet
//
//  Created by 李世远 on 2018/5/28.
//  Copyright © 2018年 Far. All rights reserved.
//

import UIKit

@objc protocol I18NProtocol {
    
    /// 允许控件国际化
    func enableI18N()
    
    /// 停止控件国际化
    func disableI18N()
    
    /// 语言更改需要控件刷新
    ///
    /// - Parameter noti: 通知 object为语言
    func refreshI18N(noti:NSNotification)
}

private var toi18nkey = ""

extension UIView:I18NProtocol {
    
    /// 国际化的key
    var I18NKey:String {
        get {
            return objc_getAssociatedObject(self, &toi18nkey) as! String
        }
        set(newValue) {
            objc_setAssociatedObject(self, &toi18nkey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func I18NLocalized(key:String) {
        enableI18N()
        I18NKey = key
        //根据不同的控件去实现text赋值还是啥的赋值
    }
    
    func refreshI18N(noti: NSNotification) {
        //根据不同的控件去实现text的更新还是啥的更新
    }
    
    func enableI18N() {
        //
        disableI18N()
        I18NManager.manager.addI18NObserver(self, selector: #selector(refreshI18N(noti:)))
    }
    func disableI18N() {
        //
        I18NManager.manager.removeI18NObserver(self)
    }
}
