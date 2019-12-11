//
//  PaintView.swift
//  DemoSet
//
//  Created by lishiyuan on 2019/11/28.
//  Copyright © 2019 Far. All rights reserved.
//

import UIKit

class PaintView: UIView {
    var paths:[PaintPath] = []
    var currentPath:PaintPath = PaintPath.init()
    var currentColor:UIColor = UIColor.black
    var pan = UIPanGestureRecognizer.init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        baseInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func baseInit() {
        pan = UIPanGestureRecognizer.init(target: self, action: #selector(paintPanAction(pan:)))
        self.addGestureRecognizer(pan)
    }
    
    @objc private func paintPanAction(pan:UIPanGestureRecognizer) {
        let point = pan.location(in: self)
        if pan.state == .began {
            var path = PaintPath.init()
            path.bezierPath = UIBezierPath.init()
            path.bezierPath.move(to: point)
            path.color = currentColor
            self.paths.append(path)
            self.currentPath = path;
        }else if pan.state == .changed {
            self.currentPath.bezierPath.addLine(to: point)
        }
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        for path in paths {
            path.color.set()
            path.bezierPath.lineWidth = path.width
            path.bezierPath.stroke()
        }
    }
    
    func draw(customPaths:[PaintPath]) {
        paths = customPaths
        setNeedsDisplay()
    }
}

struct PaintPath {
    var bezierPath = UIBezierPath.init()
    var color = UIColor.black
    var width:CGFloat = 1.0
}
