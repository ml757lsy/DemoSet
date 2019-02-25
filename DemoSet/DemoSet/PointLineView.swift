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
    var direction:CGPoint = CGPoint.zero
    var speed:CGFloat = 2
}

class PointLineView: UIView {
    var points:[Point] = []
    var lines:[[UIBezierPath]] = []
    var notes:[UIBezierPath] = []
    var timer:CADisplayLink = CADisplayLink()
    var maxPoint:Int = 40
    
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
            point.direction = CGPoint.init(x: CGFloat(arc4random()%10+1), y: CGFloat(arc4random()%10+1))
            point.speed = CGFloat(arc4random()%3+1)
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
//        timer = Timer.scheduledTimer(timeInterval: 0.06, target: self, selector: #selector(updateView), userInfo: nil, repeats: true)
        timer = CADisplayLink.init(target: self, selector: #selector(updateView))
        timer.add(to: RunLoop.current, forMode: RunLoop.Mode.default)
    }
    
    override func removeFromSuperview() {
        timer.invalidate()//全部从runloop移除 不会超限啊哈哈
        super.removeFromSuperview()
    }
    
    @objc func updateView() {
        
        for point in points {
            
            var l = point.direction.x*point.direction.x+point.direction.y*point.direction.y
            l = CGFloat(sqrtf(Float(l)))
            
            let x = point.direction.x/l*point.speed
            let y = point.direction.y/l*point.speed
            
            point.position.x += x
            point.position.y += y
            
            if point.position.x < 0 {
                point.position.x = -point.position.x
                point.direction.x = -point.direction.x
            }else if point.position.x > frame.size.width{
                point.position.x = frame.size.width*2-point.position.x
                point.direction.x = -point.direction.x
            }
            
            if point.position.y < 0 {
                point.position.y = -point.position.y
                point.direction.y = -point.direction.y
            }else if point.position.y > frame.size.height{
                point.position.y = frame.size.height*2-point.position.y
                point.direction.y = -point.direction.y
            }
        }
        
        animation()
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
        
        let alpha:CGFloat = (length - minLength)/(maxLength - minLength)
        return 1 - alpha
    }
    
    /// 触碰某点
    ///
    /// - Parameter point: 点
    func touch(point:CGPoint) {
        //以点为聚集处
    }
    
    /// 动画
    func animation() {
        layer.sublayers?.removeAll()
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

                
                let line = CAShapeLayer.init()
                line.path = path.cgPath
                line.lineWidth = 1
                line.strokeColor = UIColor.init(red: 0.3, green: 0.3, blue: 0.3, alpha: alpha).cgColor
                layer.addSublayer(line)
            }
        }
        //point
        for i in 0..<notes.count {
            let note = notes[i]
            let p  = points[i]
            note.removeAllPoints()
            note.move(to: p.position)
            note.addArc(withCenter: p.position, radius: 4, startAngle: 0, endAngle: CGFloat(Double.pi*2), clockwise: true)
            
            let point = CAShapeLayer.init()
            point.path = note.cgPath
            point.fillColor = UIColor.darkGray.cgColor
            layer.addSublayer(point)
        }
    }
}
