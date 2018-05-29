//
//  UIButton+I18NExtension.swift
//  DemoSet
//
//  Created by 李世远 on 2018/5/29.
//  Copyright © 2018年 Far. All rights reserved.
//

import UIKit

private var tostatekey:Dictionary<UInt, String> = [:]

extension UIButton {
    
    var stateKey:Dictionary<UInt, String> {
        
        get {
            let dic = objc_getAssociatedObject(self, &tostatekey)
            if dic != nil {
                return dic as! Dictionary<UInt, String>
            }else{
                return [:]
            }
            
        }
        set(newValue) {
            objc_setAssociatedObject(self, &tostatekey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        
    }

    override func I18NLocalized(key: String) {
        super.I18NLocalized(key: key)
        I18NLocalized(key: key, state: .normal)
        
    }
    
    override func refreshI18N(noti: NSNotification) {
        var dic = stateKey
        for s in stateKey.keys {
            let k = dic[s]
            I18NLocalized(key: k!, state: UIControlState.init(rawValue: s))
        }
    }
    
    func I18NLocalized(key:String, state:UIControlState) {
        disableI18N()
        enableI18N()
        var dic = stateKey
        dic.updateValue(key, forKey: state.rawValue)
        stateKey = dic
        setTitle(I18NlocalizedString(key: key), for: state)
    }

}
