//
//  UIView+Extention.swift
//  Pixseed
//
//  Created by LiShiyuan on 2017/2/13.
//  Copyright © 2017年 PerfectWorld. All rights reserved.
//

import UIKit

extension UIView{
    //frame
    
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
    
    //MARK: -
    
    /// 复制视图
    ///
    /// - Returns: view
    func copyView<T: UIView>() -> T {
        return NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self)) as! T
    }
    
    /// 反射视图
    ///
    /// - Returns: 反射后的视图
    func reflection() -> UIView {
        let copylayer = self.copyView().layer
        copylayer.transform = CATransform3DMakeRotation(CGFloat.pi, 1, 0, 0)
        copylayer.frame = copylayer.bounds
        
        let gra = CAGradientLayer()
        gra.frame = copylayer.bounds
        gra.startPoint = CGPoint.init(x: 0.5, y: 0)
        gra.endPoint = CGPoint.init(x: 0.5, y: 1)
        gra.colors = [UIColor.white.cgColor,UIColor.clear.cgColor]
        gra.locations = [0.5]
        copylayer.addSublayer(gra)
        
        let view = UIView.init(frame: self.bounds)
        view.layer.addSublayer(copylayer)
        
        return view
    }
    
    /// 转换为图片
    ///
    /// - Returns: 图片
    func toImage() -> UIImage {
        var image = UIImage()
        let size = self.bounds.size
        // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
