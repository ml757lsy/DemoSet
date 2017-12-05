//
//  BaseBannerPointView.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/12/4.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit

class BaseBannerPointView: UIView {
    
    var count:Int = 0//总数
    var lightColor:UIColor = UIColor.gray
    var unlightColor:UIColor = UIColor.lightGray

    override init(frame: CGRect) {
        super.init(frame: frame)
        initBase()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: func
    
    func initBase() {

    }
    
    func changeTo(index:Int,progress:CGFloat) {
        var size = height/2
        if size > width/CGFloat(count)/2 {
            size = width/CGFloat(count)/2
        }
        let off = (width - size*CGFloat(count))/CGFloat(count+1)
        
        layer.sublayers?.removeAll()
        
        for i in 0..<count {
            if i == index{
                let path = UIBezierPath.init()
                let p = CGPoint.init(x: off+(off+size)*CGFloat(i), y: (height-size)/2)
                path.move(to: p)
                path.addArc(withCenter: p, radius: size*progress, startAngle: -CGFloat.pi, endAngle: CGFloat.pi, clockwise: true)
                
                let shape = CAShapeLayer.init()
                shape.path = path.cgPath
                shape.fillColor = lightColor.cgColor
                shape.strokeColor = lightColor.cgColor
                layer.addSublayer(shape)
            }else{
                let path = UIBezierPath.init()
                let p = CGPoint.init(x: off+(off+size)*CGFloat(i), y: (height-size)/2)
                path.move(to: p)
                path.addArc(withCenter: p, radius: size*progress, startAngle: -CGFloat.pi, endAngle: CGFloat.pi, clockwise: true)
                
                let shape = CAShapeLayer.init()
                shape.path = path.cgPath
                shape.fillColor = unlightColor.cgColor
                shape.strokeColor = unlightColor.cgColor
                layer.addSublayer(shape)
            }
        }
    }
    
    func changeTo(index:Int) {
        
        changeTo(index: index, progress: 1)
    }
    
    func from(index:Int, to aim:Int,progress:CGFloat) {
    }
    
}
