//
//  PointLineView.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/9/13.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit

class Point:NSObject {
    
    var position:CGPoint = CGPoint.zero
    var direction:Double = Double.pi
    var speed:CGFloat = 3
}

class PointLineView: UIView {
    var points:[Point] = []
    var timer:Timer = Timer()
    
    private var minLength:CGFloat = 20//最短
    private var maxLength:CGFloat = 50//最长
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initPoint()
        initTimer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initPoint() {
        for _ in 0..<1 {
            var point = Point()
            point.position = CGPoint.init(x: CGFloat(arc4random()%500), y: CGFloat(arc4random()%500))
            point.direction = Double.pi * Double(arc4random()%100)/100
            points.append(point)
        }
    }
    
    //
    func initTimer() {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateView), userInfo: nil, repeats: true)
    }
    
    func updateView() {
        self.setNeedsDisplay()
        
        for point in points {
            let x = point.position.x + CGFloat(sin(point.direction)) * point.speed
            if x <= 0 {
                point.position.x = -x
                point.direction = Double.pi - point.direction
            }else
            if x >= width {
                point.position.x = width - x
                point.direction = Double.pi - point.direction
            }else{
                point.position.x = x
            }
            //
            let y = point.position.y + CGFloat(cos(point.direction)) * point.speed
            if y <= 0 {
                point.position.y = -y
                point.direction = Double.pi/2 + point.direction
            }else
            if y >= height {
                point.position.y = height - y
                point.direction = Double.pi*2 - point.direction
            }else{
                point.position.y = y
            }
        }
    }
    
    func length(from point:CGPoint, to point2:CGPoint)-> CGFloat{
        
        let x = Double(point2.x - point.x)
        let y = Double(point2.y - point.y)
        
        let z2 = pow(x, 2) + pow(y, 2)
        
        let z = sqrt(z2)
        
        return CGFloat(z)
    }
    
    func nextPoint(from current:CGPoint, with speed:CGFloat){
        
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        for i in 0..<points.count {
            let point1 = points[i]
            let p1 = UIBezierPath()
            UIColor.lightGray.set()
            p1.move(to: point1.position)
            p1.addArc(withCenter: point1.position, radius: 2, startAngle: 0, endAngle: CGFloat(Double.pi*2), clockwise: true)
            p1.fill()
            
            for j in i..<points.count {
                let point2 = points[j]
                
                let p2 = UIBezierPath()
                p2.move(to: point2.position)
                p2.addArc(withCenter: point2.position, radius: 2, startAngle: 0, endAngle: CGFloat(Double.pi*2), clockwise: true)
                p2.fill()
                
                let l = length(from: point1.position, to: point2.position)
                if l < maxLength {
                    var alpha = (maxLength - l)/(maxLength - minLength)
                    if l < minLength {
                        alpha = 1
                    }
                    
                    UIColor.init(colorLiteralRed: 1, green: 1, blue: 1, alpha: Float(alpha)).set()
                    
                    let path = UIBezierPath()
                    path.move(to: point1.position)
                    path.addLine(to: point2.position)
                    path.lineWidth = 1
                    path.stroke()
                    
                }
            }
        }
    }
}
