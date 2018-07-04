//
//  WaitingView.swift
//  DemoSet
//
//  Created by 李世远 on 2018/7/4.
//  Copyright © 2018年 Far. All rights reserved.
//

import UIKit

class WaitingView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    private var stop = false
    
    var points:[CAShapeLayer] = []
    
    func initPoint() {
        //3 point ...
        for i in 0..<3 {
            let lay = CAShapeLayer.init()
            lay.path = UIBezierPath.init(arcCenter: CGPoint.init(x: 10+CGFloat(i)*20, y: 10 + 20), radius: 7, startAngle: 0, endAngle: CGFloat.pi*2, clockwise: true).cgPath
            lay.fillColor = UIColor.lightGray.cgColor
            points.append(lay)
            layer.addSublayer(lay)
        }
    }
    
    func waveAnimation() {
        var cout = 0
        let interval = 0.1
        let duration = 1.0
        let pro = Int(duration/interval)
        
        let sizeMax:CGFloat = 15
        let sizeMin:CGFloat = 5
        
        stop = false
        
        Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { (t) in
            if self.stop {
                t.invalidate()
            }else{
                
                cout += 1
                if cout >= 400 {
                    cout = 0
                }
                
                for i in 0..<self.points.count {
                    let lay = self.points[i]
                    var ic = cout+i*5
                    let c = ic%pro
                    if ic/pro%2==0{
                        //da
                        ic = c
                    }else{
                        ic = pro - c
                    }
 
                    let progress = CGFloat(ic)/CGFloat(pro)
                    let size = (sizeMax-sizeMin)*progress+sizeMin
                    
                    let path = UIBezierPath.init()
                    path.addArc(withCenter: CGPoint.init(x: 10+CGFloat(i)*(sizeMax + 20), y: 10 + sizeMax), radius: size, startAngle: 0, endAngle: CGFloat.pi*2, clockwise: true)
                    lay.path = path.cgPath
                    lay.fillColor = UIColor.lightGray.cgColor
                }
            }
        }
    }
    
    func turnAniamtion() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (t) in
            //
            let point1 = self.points[0]
            let point2 = self.points[1]
            let point3 = self.points[2]
            
            let path = UIBezierPath.init()
            path.move(to: point1.position)
            path.addCurve(to: point3.position, controlPoint1: CGPoint.init(x: point1.position.x, y: point1.position.y-40), controlPoint2: CGPoint.init(x: point3.position.x, y: point1.position.y-40))
            
            let aniam = CAKeyframeAnimation.init(keyPath: "position")
            aniam.path = path.cgPath
            aniam.duration = 1
            point1.add(aniam, forKey: "position")
        }
    }
    
    func stopAnimation() {
        stop = true
    }
    

}
