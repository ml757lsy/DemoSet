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
    let offset = CGPoint.init(x: 20, y: 20)//偏移量
    let size = CGSize.init(width: 100, height: 100)//大小

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
        
        //box
        var box = PaintPath.init()
        box.width = 2
        box.bezierPath = UIBezierPath.init(roundedRect: CGRect.init(x: offset.x, y: offset.y, width: size.width, height: size.height), cornerRadius: size.width/8)
        paths.append(box)
        
        //d
        var dc = PaintPath.init()
        dc.color = UIColor.red
        dc.width = 5
        dc.bezierPath.move(to: CGPoint.init(x: offset.x + size.width/4/2, y: offset.y))
        dc.bezierPath.addQuadCurve(to: CGPoint.init(x: offset.x + size.width/4, y: offset.y + size.height/2/6), controlPoint: CGPoint.init(x: offset.x + size.width/4, y: offset.y))
        dc.bezierPath.addLine(to: CGPoint.init(x: offset.x + size.width/4, y: offset.y + size.height/2/6*5))
        dc.bezierPath.addQuadCurve(to: CGPoint.init(x: offset.x + size.width/4 - size.width/6, y: offset.y + size.height/2), controlPoint: CGPoint.init(x: offset.x + size.width/4, y: offset.y + size.height/2))
        dc.bezierPath.addLine(to: CGPoint.init(x: offset.x, y: offset.y + size.height/2))
        dc.bezierPath.addLine(to: CGPoint.init(x: offset.x, y: offset.y))
        dc.bezierPath.addLine(to: CGPoint.init(x: offset.x + size.width/4/2, y: offset.y))
        dc.bezierPath.move(to: pointScale(x: 1/8, y: 1/8))
        dc.bezierPath.addLine(to: pointScale(x: 1/8, y: 3/8))
        paths.append(dc)
        
        //e
        var ec = PaintPath.init()
        ec.color = UIColor.orange
        ec.width = 5
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
        mc.width = 5
        mc.bezierPath.move(to: CGPoint.init(x: offset.x + size.width/2, y: offset.y))
        mc.bezierPath.addLine(to: CGPoint.init(x: offset.x + size.width/4*3, y: offset.y))
        mc.bezierPath.addLine(to: CGPoint.init(x: offset.x + size.width/4*3, y: offset.y + size.height/2))
        mc.bezierPath.addLine(to: CGPoint.init(x: offset.x + size.width/2, y: offset.y + size.height/2))
        mc.bezierPath.move(to: CGPoint.init(x: offset.x + size.width/2 + size.width/4/3, y: offset.y + size.height/2))
        mc.bezierPath.addLine(to: CGPoint.init(x: offset.x + size.width/2 + size.width/4/3, y: offset.y + size.height/2 - size.height/2/3*2))
        mc.bezierPath.move(to: CGPoint.init(x: offset.x + size.width/2 + size.width/4/3*2, y: offset.y + size.height/2))
        mc.bezierPath.addLine(to: CGPoint.init(x: offset.x + size.width/2 + size.width/4/3*2, y: offset.y + size.height/2 - size.height/2/3*2))
        paths.append(mc)
        
        //o
        var oc = PaintPath.init()
        oc.color = UIColor.cyan
        oc.width = 5
        oc.bezierPath.move(to: CGPoint.init(x: offset.x + size.width/4*3+size.width/4/2, y: offset.y))
        oc.bezierPath.addQuadCurve(to: CGPoint.init(x: offset.x + size.width, y: offset.y + size.height/2/6), controlPoint: CGPoint.init(x: offset.x + size.width, y: offset.y))
        oc.bezierPath.addLine(to: CGPoint.init(x: offset.x + size.width, y: offset.y + size.height/2*5/6))
        oc.bezierPath.addQuadCurve(to: CGPoint.init(x: offset.x + size.width - size.width/4/2, y: offset.y + size.height/2), controlPoint: CGPoint.init(x: offset.x + size.width, y: offset.y + size.height/2))
        oc.bezierPath.addQuadCurve(to: CGPoint.init(x: offset.x + size.width - size.width/4, y: offset.y + size.height/2 - size.height/2/6), controlPoint: CGPoint.init(x: offset.x + size.width - size.width/4, y: offset.y + size.height/2))
         oc.bezierPath.addLine(to: CGPoint.init(x: offset.x + size.width*3/4, y: offset.y + size.height/2/6))
        oc.bezierPath.addQuadCurve(to: CGPoint.init(x: offset.x + size.width/4*3+size.width/4/2, y: offset.y), controlPoint: CGPoint.init(x: offset.x + size.width - size.width/4, y: offset.y))
        oc.bezierPath.move(to: point(x: size.width/4*3+size.width/4/2, y: size.height/2/4))
        oc.bezierPath.addLine(to: point(x: size.width/4*3+size.width/4/2, y: size.height/2/4*3))
        paths.append(oc)
        
        //s
        var sc = PaintPath.init()
        sc.color = UIColor.blue
        sc.width = 5
        sc.bezierPath.move(to: pointScale(x: 0, y: 1/2))
        sc.bezierPath.addLine(to: pointScale(x: 1/3, y: 1/2))
        sc.bezierPath.addLine(to: pointScale(x: 1/3, y: 1))
        sc.bezierPath.addLine(to: pointScale(x: 0, y: 1))
        sc.bezierPath.addLine(to: pointScale(x: 0, y: 1/2))
        sc.bezierPath.move(to: pointScale(x: 1/3, y: 1/2+1/6))
        sc.bezierPath.addLine(to: pointScale(x: 1/6, y: 1/2+1/6))
        sc.bezierPath.move(to: pointScale(x: 0, y: 1-1/6))
        sc.bezierPath.addLine(to: pointScale(x: 1/6, y: 1-1/6))
        paths.append(sc)
        
        //ee
        var eec = PaintPath.init()
        eec.color = UIColor.purple
        eec.width = 5
        eec.bezierPath.move(to: pointScale(x: 1/3, y: 1/2))
        eec.bezierPath.addLine(to: pointScale(x: 2/3, y: 1/2))
        eec.bezierPath.addLine(to: pointScale(x: 2/3, y: 1))
        eec.bezierPath.addLine(to: pointScale(x: 1/3, y: 1))
        eec.bezierPath.addLine(to: pointScale(x: 1/3, y: 1/2))
        eec.bezierPath.move(to: pointScale(x: 1/3+1/6, y: 1/2+1/6))
        eec.bezierPath.addLine(to: pointScale(x: 2/3, y: 1/2+1/6))
        eec.bezierPath.move(to: pointScale(x: 1/3+1/6, y: 5/6))
        eec.bezierPath.addLine(to: pointScale(x: 2/3, y: 5/6))
        paths.append(eec)
        
        //tc
        var tc = PaintPath.init()
        tc.color = UIColor.magenta
        tc.width = 5
        tc.bezierPath.move(to: pointScale(x: 2/3, y: 1/2))
        tc.bezierPath.addLine(to: pointScale(x: 1, y: 1/2))
        tc.bezierPath.addLine(to: pointScale(x: 1, y: 1/2+1/6))
        tc.bezierPath.addLine(to: pointScale(x: 1-1/6, y: 1/2+1/6))
        tc.bezierPath.addLine(to: pointScale(x: 1-1/6, y: 1))
        tc.bezierPath.addLine(to: pointScale(x: 2/3, y: 1))
        tc.bezierPath.addLine(to: pointScale(x: 2/3, y: 1/2))
        tc.bezierPath.lineJoinStyle = .round
        paths.append(tc)
        
        paintview.draw(customPaths: paths)
    }
    
    /// 自动计算偏移量的点
    /// - Parameters:
    ///   - x: x位置
    ///   - y: y位置
    func point(x:CGFloat,y:CGFloat)->CGPoint{
        return CGPoint.init(x: offset.x + x, y: offset.y + y)
    }
    
    /// 根据比例来创建
    /// - Parameters:
    ///   - x: xscale 0-1
    ///   - y: yscale 0-1
    func pointScale(x:CGFloat, y:CGFloat) -> CGPoint {
        return point(x: x*size.width, y: y*size.height)
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
