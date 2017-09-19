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
    var lines:[[UIBezierPath]] = []
    var notes:[UIBezierPath] = []
    var timer:Timer = Timer()
    var maxPoint:Int = 10
    
    private var minLength:CGFloat = 30//最短
    private var maxLength:CGFloat = 80//最长
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initPoint()
        initTimer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initPoint() {
        //point
        for _ in 0..<maxPoint{
            var point = Point()
            point.position = CGPoint.init(x: CGFloat(arc4random()%500), y: CGFloat(arc4random()%500))
            point.direction = Double.pi * Double(arc4random()%100)/100
            points.append(point)
        }
        //line
        for i in 0..<maxPoint {
            var li:[UIBezierPath] = []
            for j in i..<maxPoint {
                let path = UIBezierPath.init()
                path.lineWidth = 1
                li.append(path)
            }
            lines.append(li)
        }
        //notes
        for _ in 0..<maxPoint {
            let path = UIBezierPath.init()
            notes.append(path)
        }
    }
    
    //
    func initTimer() {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateView), userInfo: nil, repeats: true)
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
    
    func lineAlpha(with length:CGFloat) -> CGFloat{
        
        if length <= minLength {
            return 1
        }
        if length >= maxLength {
            return 0
        }
        
        return (length - minLength)/(maxLength - minLength)
    }
    
    func nextPoint(from current:CGPoint, with speed:CGFloat){
        
    }
    
    func animation() {
        //line
        for i in 0..<lines.count {
            let li = lines[i]
            let p1 = points[i]
            for j in 0..<li.count {
                let path = li[j]
                let p2 = points[i+j]
                path.removeAllPoints()
                path.move(to: p1.position)
                path.addLine(to: p2.position)
                let alpha = lineAlpha(with: length(from: p1.position, to: p2.position))
                UIColor.init(white: 1, alpha: alpha).set()
                path.stroke()
            }
        }
        //point
        for i in 0..<notes.count {
            let note = notes[i]
            let p  = points[i]
            note.removeAllPoints()
            note.move(to: p.position)
            UIColor.darkGray.set()
            note.addArc(withCenter: p.position, radius: 2, startAngle: 0, endAngle: CGFloat(Double.pi*2), clockwise: true)
            note.fill()
        }
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        animation()
    }
}
