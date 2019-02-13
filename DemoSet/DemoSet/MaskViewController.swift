//
//  MaskViewController.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/10/16.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit

class MaskViewController: BaseViewController {

    private let imageMaskView:UIView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.yellow//绿色背景

        initMaskView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func initMaskView() {
        
        //s
        let line = UIView.init(frame: CGRect.init(x: 10, y: 40, width: 300, height: 20))
        line.backgroundColor = UIColor.red
        view.addSubview(line)
        
        //
        let image = UIImageView.init(frame: CGRect.init(x: 20, y: 20, width: 100, height: 100))
        image.image = UIImage.init(named: "Avatar")
        image.clipsToBounds = true
        image.backgroundColor = UIColor.red
        view.addSubview(image)
        
        if image.mask != nil {
            let submask = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
            submask.backgroundColor = UIColor.red
            image.mask?.addSubview(submask)
        }else{
            let submask = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
            submask.backgroundColor = UIColor.white
            image.mask = submask
            
            UIView.animate(withDuration: 1, animations: {
                submask.frame = CGRect.init(x: 50, y: 50, width: 50, height: 50)
            }, completion: { (succ) in
                UIView.animate(withDuration: 1, animations: {
                    submask.frame = CGRect.init(x: 0, y: 0, width: 25, height: 25)
                })
            })
            //sub+1
            let sub = UIView.init(frame: CGRect.init(x: 0, y: 5, width: 30, height: 20))
            sub.backgroundColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.8)
            submask.addSubview(sub)
            UIView.animate(withDuration: 1, animations: {
                sub.frame = CGRect.init(x: 50, y: 50, width: 50, height: 40)
            }, completion: { (succ) in
                //
                UIView.animate(withDuration: 1, animations: {
                    sub.frame = CGRect.init(x: 60, y: 5, width: 20, height: 80)
                    sub.backgroundColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.2)
                }, completion: { (succ) in
                    //
                })
            })
        }
        //rgb
        let rgb = UIImage.init(named: "banner1")
        let im1 = UIImageView.init(frame: CGRect.init(x: 50, y: 200, width: 100, height: 100))
        im1.image = rgb?.rbgReset(r: 1.0, g: 0.0, b: 1.0, a: 1.0)
        view.addSubview(im1)
        let im2 = UIImageView.init(frame: CGRect.init(x: 150, y: 200, width: 100, height: 100))
        im2.image = rgb?.rbgReset(r: 1.0, g: 1.0, b: 0.0, a: 1.0)
        view.addSubview(im2)
        let im3 = UIImageView.init(frame: CGRect.init(x: 250, y: 200, width: 100, height: 100))
        im3.image = rgb?.rbgReset(r: 0.0, g: 1.0, b: 1.0, a: 1.0)
        view.addSubview(im3)
        
        //
        let longtap = UIPanGestureRecognizer.init(target: self, action: #selector(longTapHandler(with:)))
        view.addGestureRecognizer(longtap)
        
        let image1 = UIImage.init(named: "banner1")
        let image2 = UIImage.init(named: "banner5")
        
        let img1 = UIImageView.init(frame: CGRect.init(x: 10, y: 300, width: 300, height: 300))
        img1.image = image1
        img1.clipsToBounds = true
        view.addSubview(img1)
        
        let img2 = UIImageView.init(frame: CGRect.init(x: 10, y: 300, width: 300, height: 300))
        img2.image = image2
        img2.clipsToBounds = true
        view.addSubview(img2)
        
        img2.mask = imageMaskView//可以指定不规则图形，做很多骚套路，比如透镜效果，刮开效果等
        imageMaskView.backgroundColor = UIColor.white
        imageMaskView.frame = CGRect.init(x: 0, y: 0, width: 80, height: 80)
        
        
        return
        //
        let back = UIView.init(frame: CGRect.init(x: 20, y: 140, width: 100, height: 100))
        back.backgroundColor = UIColor.red
        view.addSubview(back)
        
        let path = UIBezierPath.init()
        path.move(to: CGPoint.zero)
        path.addLine(to: CGPoint.init(x: 100, y: 100))
        path.addLine(to: CGPoint.init(x: 0, y: 100))
        path.addLine(to: CGPoint.zero)
        path.stroke()
        
        let shap = CAShapeLayer.init()
        shap.path = path.cgPath
        shap.lineWidth = 3
        shap.strokeColor = UIColor.red.cgColor
        shap.strokeColor = UIColor.purple.cgColor
        
        back.mask = UIView.init(frame: back.frame)
        back.backgroundColor = UIColor.blue
        back.layer.mask = shap
        
    }
    
    func longTapHandler(with tap:UIPanGestureRecognizer) {
        let p = tap.location(in: view)
        imageMaskView.center = CGPoint.init(x: p.x-10, y: p.y-300)
    }
    
    func image() {
        let earth = UIImage()
        let m = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 10, height: 10))
        m.backgroundColor = UIColor.brown
        let moton =  m.toImage()
        
        let l = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 10, height: 10))
        l.backgroundColor = UIColor.blue
        let low = l.toImage()
        
        let d = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 10, height: 10))
        d.backgroundColor = UIColor.black
        let dong = d.toImage()
     
        var resized = UIImage()
        
        UIGraphicsBeginImageContext(CGSize.init(width: 30, height: 12756+9))
        let context:CGContext = UIGraphicsGetCurrentContext()!
        context.interpolationQuality = .low
        moton.draw(in: CGRect.init(x: 0, y: 0, width: 10, height: 9))
        earth.draw(in: CGRect.init(x: 0, y: 9, width: 30, height: 12756))
        low.draw(in: CGRect.init(x: 10, y: 9, width: 10, height: 11))
        dong.draw(in: CGRect.init(x: 20, y: 9, width: 10, height: 12.5))
        
        resized = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        let data = UIImageJPEGRepresentation(resized, 1.0)
        do {
//            try data?.write(to: URL.init(fileURLWithPath: "/Users/lishiyuan/Desktop/long.jpg"))
        } catch let error {
            //
        }
        
    }

}
