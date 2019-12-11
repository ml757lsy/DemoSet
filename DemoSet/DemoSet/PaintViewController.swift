//
//  PaintViewController.swift
//  DemoSet
//
//  Created by lishiyuan on 2019/11/28.
//  Copyright © 2019 Far. All rights reserved.
//

import UIKit

class PaintViewController: BaseViewController {
    
    var paintview = PaintView.init()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        paintview = PaintView.init(frame: CGRect.init(x: 20, y: 20, width: SCREENWIDTH-40, height: SCREENWIDTH-40))
        paintview.backgroundColor = UIColor.init(white: 0.98, alpha: 1)
        view.addSubview(paintview)
        
        drawDEMOSET()
    }
    
    func colorSet() {
        let colors = [UIColor.red,UIColor.orange,UIColor.yellow,UIColor.green,UIColor.blue,UIColor.black]
        let names = ["Red","Orange","Yellow","Green","Blue","Black"]
        for i in 0..<names.count {
            let button = UIButton.init(type: .custom)
            button.setTitle(names[i], for: .normal)
            button.setTitleColor(colors[i], for: .normal)
            button.frame = CGRect.init(x: 20, y: paintview.bottom, width: paintview.width/CGFloat(names.count)-5, height: 40)
            button.addTarget(self, action: #selector(colorButtonClick), for: .touchUpInside)
            view.addSubview(button)
        }
    }
    
    @objc func colorButtonClick() {
        
    }
    
    func drawDEMOSET() {
        var paths:[PaintPath] = []
        
        let offset = CGPoint.init(x: 20, y: 20)
        let size = CGSize.init(width: 100, height: 100)
        //box
        var box = PaintPath.init()
        box.width = 3
        box.bezierPath = UIBezierPath.init(roundedRect: CGRect.init(x: offset.x, y: offset.y, width: size.width, height: size.height), cornerRadius: size.width/15)
        paths.append(box)
        
        //d
        var dc = PaintPath.init()
        dc.color = UIColor.red
        dc.width = 3
        dc.bezierPath.move(to: CGPoint.init(x: offset.x + size.width/4/2, y: offset.y))
        dc.bezierPath.addQuadCurve(to: CGPoint.init(x: offset.x + size.width/4, y: offset.y + size.height/2/6), controlPoint: CGPoint.init(x: offset.x + size.width/4, y: offset.y))
        dc.bezierPath.addLine(to: CGPoint.init(x: offset.x + size.width/4, y: offset.y + size.height/2/6*5))
        dc.bezierPath.addQuadCurve(to: CGPoint.init(x: offset.x + size.width/4 - size.width/6, y: offset.y + size.height/2), controlPoint: CGPoint.init(x: offset.x + size.width/4, y: offset.y + size.height/2))
        dc.bezierPath.addLine(to: CGPoint.init(x: offset.x, y: offset.y + size.height/2))
        dc.bezierPath.addLine(to: CGPoint.init(x: offset.x, y: offset.y))
        dc.bezierPath.addLine(to: CGPoint.init(x: offset.x + size.width/4/2, y: offset.y))
        paths.append(dc)
        
        //e
        var ec = PaintPath.init()
        ec.color = UIColor.orange
        ec.width = 3
        ec.bezierPath.move(to: CGPoint.init(x: offset.x + size.width/4/2, y: offset.y))
        ec.bezierPath.addLine(to: CGPoint.init(x: offset.x + size.width/2, y: offset.y))
        ec.bezierPath.addLine(to: CGPoint.init(x: offset.x + size.width/2, y: offset.y + size.height/2))
        ec.bezierPath.addLine(to: CGPoint.init(x: offset.x + size.width/4/2, y: offset.y + size.height/2))
        ec.bezierPath.move(to: CGPoint.init(x: offset.x + size.width/2, y: offset.y + size.height/2/3))
        ec.bezierPath.addLine(to: CGPoint.init(x: offset.x + size.width/4 + size.width/4/2, y: offset.y + size.height/2/3))
        ec.bezierPath.move(to: CGPoint.init(x: offset.x + size.width/2, y: offset.y + size.height/2/3*2))
        ec.bezierPath.addLine(to: CGPoint.init(x: offset.x + size.width/4 + size.width/4/2, y: offset.y + size.height/2/3*2))
        paths.append(ec)
        
        //m
        var mc = PaintPath.init()
        mc.color = UIColor.green
        mc.width = 3
        mc.bezierPath.move(to: CGPoint.init(x: offset.x + size.width/2, y: offset.y))
        mc.bezierPath.addLine(to: CGPoint.init(x: offset.x + size.width/4*3, y: offset.y))
        mc.bezierPath.addLine(to: CGPoint.init(x: offset.x + size.width/4*3, y: offset.y + size.height/2))
        mc.bezierPath.addLine(to: CGPoint.init(x: offset.x + size.width/2, y: offset.y + size.height/2))
        mc.bezierPath.move(to: CGPoint.init(x: offset.x + size.width/2 + size.width/4/3, y: offset.y + size.height/2))
        mc.bezierPath.addLine(to: CGPoint.init(x: offset.x + size.width/2 + size.width/4/3, y: offset.y + size.height/2 - size.height/2/3*2))
        mc.bezierPath.move(to: CGPoint.init(x: offset.x + size.width/2 + size.width/4/3*2, y: offset.y + size.height/2))
        mc.bezierPath.addLine(to: CGPoint.init(x: offset.x + size.width/2 + size.width/4/3*2, y: offset.y + size.height/2 - size.height/2/3*2))
        paths.append(mc)
        
        paintview.draw(customPaths: paths)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
