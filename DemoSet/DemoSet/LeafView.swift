//
//  LeafView.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/6/29.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit

class LeafView: UIView {
    private var progress:Int = 0
    private var shape:CAShapeLayer = CAShapeLayer()
    

    override init(frame:CGRect){
        super.init(frame: frame)
        initLeaf()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initLeaf() {
        shape.frame = self.bounds
        self.layer.addSublayer(shape)
        updateView()
    }
    
    func start() {
        UIView.animate(withDuration: 0.1, animations: { 
            //
            self.progress += 1
            if self.progress >= 100{
                self.progress = 0
            }
        }) { (finish) in
            //
        }
    }
    
    func updateView() {
        let leafpath = UIBezierPath.init()
        leafpath.move(to: CGPoint.init(x: self.width/2, y: self.height))
        leafpath.addCurve(to: CGPoint.init(x: self.width/2, y: 0), controlPoint1: CGPoint.init(x: self.width, y: self.height/2), controlPoint2: CGPoint.init(x: self.width, y: self.height/2))
        leafpath.addCurve(to: CGPoint.init(x: self.width/2, y: self.height), controlPoint1: CGPoint.init(x: 0, y: self.height/2), controlPoint2: CGPoint.init(x: 0, y: self.height/2))
        shape.path = leafpath.cgPath
        shape.lineWidth = 2
        shape.strokeColor = UIColor.red.cgColor
        shape.fillColor = UIColor.green.cgColor
        
        setNeedsDisplay()
    }

}
