
//
//  WaveView.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/9/19.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit

class WaveView: UIView {
    private var waves:[UIBezierPath] = []
    private var shapes:[CAShapeLayer] = []
    private var colors:[UIColor] = []
    
    var waveLength:CGFloat = 200
    var waveHeight:CGFloat = 30
    var waveOff:CGFloat = 100
    
    var waveNum:Int = 3
    
    var offset:CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initWave()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initWave() {
        for _ in 0..<waveNum {
            let path = UIBezierPath.init()
            waves.append(path)
        }
        
        for _ in 0..<waveNum {
            let shape = CAShapeLayer.init()
            layer.addSublayer(shape)
            shapes.append(shape)
        }
        
        colors.append(UIColor.red)
        colors.append(UIColor.yellow)
        colors.append(UIColor.blue)
    }
    
    @objc func animation() {
        offset += 2
        
        for i in 0..<waves.count {
            let path = waves[i]
            path.removeAllPoints()
            
            path.move(to: CGPoint.init(x: 0, y: waveOff))
            
            for j in 0..<Int(width) {
                let ang = (CGFloat(j)+offset+CGFloat(i*68))/waveLength*CGFloat.pi*2
                let h = sin(ang)*waveHeight
                let y = h + waveOff
                path.addLine(to: CGPoint.init(x: CGFloat(j), y: y))
            }
            path.addLine(to: CGPoint.init(x: width, y: 0))
            path.addLine(to: CGPoint.init(x: 0, y: 0))
            
            let shape = shapes[i]
            shape.fillColor = colors[i%colors.count].cgColor
            shape.opacity = 0.5
            shape.path = path.cgPath
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let link = CADisplayLink.init(target: self, selector: #selector(animation))
        link.add(to: RunLoop.main, forMode: RunLoop.Mode.common)
    }

}
