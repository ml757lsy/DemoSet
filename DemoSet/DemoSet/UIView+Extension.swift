//
//  UIView+Extention.swift
//  Pixseed
//
//  Created by LiShiyuan on 2017/2/13.
//  Copyright © 2017年 PerfectWorld. All rights reserved.
//

import UIKit

extension UIView{
    var height: CGFloat{
        set(newValue) {
            self.frame = CGRect.init(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width, height: newValue)
        }
        get{
            return self.frame.size.height
        }
    }
    var width: CGFloat{
        set(newValue) {
            self.frame = CGRect.init(x: self.frame.origin.x, y: self.frame.origin.y, width: newValue, height: self.frame.size.height)
        }
        get{
            return self.frame.size.width
        }
    }
    var x: CGFloat{
        set(newValue) {
            self.frame = CGRect.init(x: newValue, y: self.frame.origin.y, width: self.frame.size.width, height: self.frame.size.height)
        }
        get{
            return self.frame.origin.x
        }
    }
    var y: CGFloat{
        set(newValue) {
            self.frame = CGRect.init(x: self.frame.origin.x, y: newValue, width: self.frame.size.width, height: self.frame.size.height)
        }
        get{
            return self.frame.origin.y
        }
    }
    var right: CGFloat {
        set(newValue) {
            self.frame = CGRect.init(x: newValue - self.frame.size.width, y: self.frame.origin.y, width: self.frame.size.width, height: self.frame.size.height)
        }
        get{
            return self.frame.origin.x + self.frame.size.width
        }
    }
    var bottom: CGFloat {
        set(newValue) {
            self.frame = CGRect.init(x: self.frame.origin.x, y: newValue - self.frame.size.height, width: self.frame.size.width, height: self.frame.size.height)
        }
        get{
            return self.frame.origin.y + self.frame.size.height
        }
    }
    var centerX: CGFloat{
        set(newValue) {
            self.center = CGPoint.init(x: newValue, y: self.center.y)
        }
        get{
            return self.center.x
        }
    }
    var centerY: CGFloat{
        set(newValue) {
            self.center = CGPoint.init(x: self.center.x, y: newValue)
        }
        get{
            return self.center.y
        }
    }
}
