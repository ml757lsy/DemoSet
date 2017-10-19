//
//  QRCodeMaskView.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/10/10.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit

class QRCodeMaskView: QRCodeView {
    
    var data:[[Int]] = []//

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let path = UIBezierPath.init()
        path.move(to: CGPoint.init(x: 10, y: 10))
        path.addLine(to: CGPoint.init(x: 100, y: 100))
        path.addLine(to: CGPoint.init(x: 100, y: 0))
        path.close()
        
        let shap = CAShapeLayer.init()
        shap.path = path.cgPath
        
        //
        mask = UIView.init(frame: CGRect.init(x: 10, y: 10, width: 100, height: 100))
        mask?.backgroundColor = UIColor.green
        mask?.layer.mask = shap
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func mask() {
        
    }
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        mask()
    }

}
