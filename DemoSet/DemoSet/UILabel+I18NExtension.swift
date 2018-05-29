//
//  UILabel+I18NExtension.swift
//  DemoSet
//
//  Created by 李世远 on 2018/5/28.
//  Copyright © 2018年 Far. All rights reserved.
//

import UIKit

extension UILabel {

    override func I18NLocalized(key: String) {
        super.I18NLocalized(key: key)
        self.text = I18NlocalizedString(key: key)
        
    }
    
    override func refreshI18N(noti: NSNotification) {
        self.text = I18NlocalizedString(key: self.I18NKey)
    }
}
