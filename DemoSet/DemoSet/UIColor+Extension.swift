//
//  UIColor+Extension.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/10/20.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit

extension  UIColor {
    
    /// 随机色
    ///
    /// - Returns: 颜色
    class func randomColor() ->UIColor {
        return UIColor.init(red: CGFloat(arc4random()%256)/255, green: CGFloat(arc4random()%256)/255, blue: CGFloat(arc4random()%256)/255, alpha: 1)
    }
}
