//
//  MaskViewController.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/10/16.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit

class MaskViewController: BaseViewController {

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

}
