//
//  AnimationViewController.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/6/29.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit
import SnapKit

class AnimationViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let leaf = LeafView.init(frame: CGRect.init(x: 20, y: 20, width: 70, height: 100))
        view.addSubview(leaf)
        glow()
        scribble()
        vegas()
        
        snapkitAnimation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func scribble() {
        var points:[CGPoint] = []
        let n = 16
        let size:CGFloat = 200
        var add:Bool = true
        let offset:CGFloat = 50
        
        let line = CAShapeLayer()
        
        _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (t) in
            //add
            if points.count < n*4 && add {
                var x:CGFloat =  CGFloat(arc4random()%4)
                var y:CGFloat =  CGFloat(arc4random()%4)
                
                if points.count < n*2 {
                    if points.count % 2 == 0{
                        y = offset + size/CGFloat(n)*CGFloat(points.count/2)
                        x = offset + x
                    }else{
                        x = offset + size/CGFloat(n)*CGFloat(points.count/2)
                        y = offset + y
                    }
                }else{
                    if points.count % 2 == 0 {
                        x = offset + size/CGFloat(n)*CGFloat((points.count-2*n)/2)
                        y = offset + size - y
                    }else{
                        y = offset + size/CGFloat(n)*CGFloat((points.count-2*n)/2)
                        x = offset + size - x
                    }
                }
                
                let p = CGPoint.init(x: x, y: y)
                points.append(p)
            }else{
                add = false
                if points.count > 0 {
                    points.remove(at: 0)
                }else{
                    add = true
                }
            }
            //line
            line.removeFromSuperlayer()
            let path = UIBezierPath.init()
            if points.count > 0 {
                path.move(to: points[0])
            }
            for p in points{
                path.addLine(to: p)
            }
            
            line.path = path.cgPath
            line.lineWidth = 1
            line.strokeColor = UIColor.red.cgColor
            line.fillColor = UIColor.clear.cgColor
            
            self.view.layer.addSublayer(line)

        }
    }
    
    func glow() {
        var transfrom = CGAffineTransform.init(scaleX: 1.1, y: 1.1)
        let v = UIView.init(frame: CGRect.init(x: 50, y: 200, width: 100, height: 100))
        v.backgroundColor = UIColor.lightGray
        view.addSubview(v)
        v.layer.shadowColor = UIColor.yellow.cgColor
        v.layer.shadowOpacity = 0.8
        v.layer.shadowOffset = CGSize.init(width: -10, height: -10)
        v.layer.shadowPath = CGPath.init(rect: v.bounds, transform: &transfrom)
        
        var p:CGFloat = 1
        var c:CGFloat = 1
        
        _ = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true, block: { (t) in
            //
            p += c
            v.layer.shadowRadius = p
            if p > 50 {
                c = -1
            }
            if p < 10 {
                c = 1
            }
        })
    }
    
    func vegas() {
        let v = UIView.init(frame: CGRect.init(x: 200, y: 100, width: 100, height: 100))
        v.backgroundColor = UIColor.gray
        view.addSubview(v)
        
        let veg = CAShapeLayer.init()
        veg.frame = v.bounds
        v.layer.addSublayer(veg)
        
        let s1 = CAGradientLayer.init()
        s1.frame = CGRect.init(x: 0, y: 0, width: 100, height: 10)
        s1.colors = [UIColor.clear.cgColor,UIColor.white.cgColor,UIColor.clear.cgColor]
        s1.startPoint = CGPoint.init(x: 0, y: 0)
        s1.endPoint = CGPoint.init(x: 1, y: 0)
        s1.locations = [-1,0,0]
        veg.addSublayer(s1)
        
        
        var x:CGFloat = 0
        
        _ = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: { (t) in
            x += 1
            let p:CGFloat = 1 * (x/100)
            let l1 = NSNumber.init(value: Float(p-1))
            let l2 = NSNumber.init(value: Float(p))
            
            s1.locations = [l1,l2,l2]
            
            if x >= 100 {
                x = 0
                s1.transform = CATransform3DMakeRotation(CGFloat.pi, 0, 0, 0)
            }
        })
        
        
    }
    
    //MARK: - snapkit
    func snapkitAnimation() {
        let snpview = UIView.init()
        snpview.backgroundColor = UIColor.randomColor()
        view.addSubview(snpview)
        
        snpview.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.width.equalTo(200)
            make.height.equalTo(100)
            make.top.equalTo(300)
        }
        
        //执行顺序
        snpview.setNeedsLayout()
        snpview.updateConstraints()
        
        UIView.animate(withDuration: 4, animations: {
            snpview.layoutIfNeeded()//显示动画
        }) { (b) in
            //
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
