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
    var testLayer = CAShapeLayer()
    
    func initPoint() {
        backgroundColor = UIColor.yellow
        //3 point ...
        for i in 0..<3 {
            let lay = CAShapeLayer.init()
            let position = CGPoint.init(x: 10+CGFloat(i)*30, y: 10+20)
            lay.path = UIBezierPath.init(arcCenter: position, radius: 7, startAngle: 0, endAngle: CGFloat.pi*2, clockwise: true).cgPath
            lay.fillColor = UIColor.lightGray.cgColor
            points.append(lay)
            layer.addSublayer(lay)
            
        }
        
        layer.addSublayer(testLayer)
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
        Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { (t) in
            //
            let point1 = self.points[0]
            let point2 = self.points[1]
            let point3 = self.points[2]
            
            print("\(point1.position)-\(point2.position)-\(point3.position)")
            let height:CGFloat = 20
            
            let path = UIBezierPath.init()
            path.move(to: CGPoint.init(x: 10, y: 10+20))
            path.addCurve(to: CGPoint.init(x: 10+30*2, y: 10+20), controlPoint1: CGPoint.init(x: 10, y: 10+20-height), controlPoint2: CGPoint.init(x: 10+30*2, y: 10+20-height))
//            path.addLine(to: CGPoint.init(x: 10+30*2, y: 10+20))
            let aniam = CAKeyframeAnimation.init(keyPath: "position")
            aniam.path = path.cgPath
            aniam.duration = 2
            aniam.isRemovedOnCompletion = false
            point1.add(aniam, forKey: "position")
            
            
            //FIXME: path OK
            self.testLayer.path = path.cgPath
            self.testLayer.lineWidth = 4
            self.testLayer.strokeColor = UIColor.red.cgColor
            self.testLayer.fillColor = UIColor.red.cgColor
            
            //
            let path2 = UIBezierPath.init()
            path2.move(to: CGPoint.init(x: 10, y: 10+20))
            path2.addCurve(to: CGPoint.init(x: 10+30*1, y: 10+20), controlPoint1: CGPoint.init(x: 10+30*1, y: 10+20-height), controlPoint2: CGPoint.init(x: 10, y: 10+20-height))
            let aniam2 = CAKeyframeAnimation.init(keyPath: "position")
            aniam2.path = path2.cgPath
            aniam2.duration = 2
            aniam2.isRemovedOnCompletion = false
            point2.add(aniam2, forKey: "position")
            
            //
            let path3 = UIBezierPath.init()
            path3.move(to: CGPoint.init(x: 10+30*2, y: 10+20))
//            path3.addCurve(to: CGPoint.init(x: 10+30*1, y: 10+20), controlPoint1: CGPoint.init(x: 10+30*2, y: 10+20+height), controlPoint2: CGPoint.init(x: 10+30*1, y: 10+20+height))
            path3.addQuadCurve(to: CGPoint.init(x: 10+30*1, y: 10+20), controlPoint: CGPoint.init(x: 55, y: 10+30+height))
            let aniam3 = CAKeyframeAnimation.init(keyPath: "position")
            aniam3.path = path3.cgPath
            aniam3.duration = 2
            aniam3.isRemovedOnCompletion = false
            point3.add(aniam3, forKey: "position")
            
        }
    }
    
    func stopAnimation() {
        stop = true
    }
    
    deinit {
        stopAnimation()
    }
}
