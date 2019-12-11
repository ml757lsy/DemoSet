//
//  ReaderContentViewController.swift
//  DemoSet
//
//  Created by 李世远 on 2018/6/26.
//  Copyright © 2018年 Far. All rights reserved.
//

import UIKit

class ReaderContentViewController: BaseViewController {

    var files:[String] = []
    var current:Int = 0
    
    private let imageView = UIImageView()
    
    var tempPoint = CGPoint.zero
    
    var tempScal:CGFloat = 1.0
    let maxScale:CGFloat = 4.0
    let minScale:CGFloat = 0.5
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView() {
        view.addSubview(imageView)
        imageView.frame = view.bounds
        imageView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(0)
        }
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        if files.count > 0 {
            imageView.image = UIImage.contentsOfFile(path: files[current])
        }
        
        let controlView = UIView.init(frame: view.bounds);
        view.addSubview(controlView);
        
        let swipleft = UISwipeGestureRecognizer.init(target: self, action: #selector(swipe(ges:)))
        swipleft.direction = .left
        controlView.addGestureRecognizer(swipleft)
        let swipright = UISwipeGestureRecognizer.init(target: self, action: #selector(swipe(ges:)))
        swipright.direction = .right
        controlView.addGestureRecognizer(swipright)
        
        let pin = UIPinchGestureRecognizer.init(target: self, action: #selector(pine(ges:)))
        controlView.addGestureRecognizer(pin)
        
        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(pan(ges:)))
        controlView.addGestureRecognizer(pan)
        
        let double = UITapGestureRecognizer.init(target: self, action: #selector(doubleClick(ges:)))
        double.numberOfTapsRequired = 2
        controlView.addGestureRecognizer(double)
        
        let back = UIButton.init(type: .system)
        back.setTitle("返回", for: .normal)
        back.frame = CGRect.init(x: 0, y: 0, width: 44, height: 44)
        back.addTarget(self, action: #selector(backToLast), for: .touchUpInside)
        
        let right = UIBarButtonItem.init(customView: back)
        navigationItem.rightBarButtonItem = right
        
    }
    
    @objc func swipe(ges:UISwipeGestureRecognizer) {
        if ges.direction == .left {
            current += 1
        }else{
            current -= 1
        }
        
        if current < 0 {
            current = files.count + current
        }
        if  current >= files.count {
            current = current - files.count
        }
        imageView.image = UIImage.contentsOfFile(path: files[current])
    }
    
    @objc func pine(ges:UIPinchGestureRecognizer) {
        let scale = ges.scale
        if ges.state == .began {
            tempScal = scale
        }else if ges.state == .changed {
            self.imageView.transform = self.imageView.transform.scaledBy(x: scale/tempScal, y: scale/tempScal)
            tempScal = scale;
        }else if ges.state == .ended {
            self.transformLimit();
        }
    }
    
    @objc func pan(ges:UIPanGestureRecognizer) {
        
        let point = ges.location(in: self.view)
        if ges.state == .began {
            tempPoint = ges.location(in: ges.view)
        }else if ges.state == .changed {
            let x = (point.x - self.tempPoint.x)
            let y = (point.y - self.tempPoint.y)
            self.imageView.x += x
            self.imageView.y += y
            self.tempPoint = point
        }else if ges.state == .ended {
            self.transformLimit()
        }
    }
    
    @objc func doubleClick(ges:UITapGestureRecognizer) {
        var scale:CGFloat = 1.75
        
        //点击的点来放大
        let p = ges.location(in: self.view)
        let x = self.view.width/2 - p.x
        let y = self.view.height/2 - p.y
        var center = CGPoint.init(x: x+self.imageView.center.x, y: y+self.imageView.center.y)
        
        //二次复原
        if (self.imageView.transform.a > 2.5) {
            scale = 1/self.imageView.transform.a
            center = CGPoint.init(x: self.view.width/2, y: self.view.height/2)
        }
        UIView.animate(withDuration: 0.4, animations: {
            self.imageView.center = center;
            self.imageView.transform = self.imageView.transform.scaledBy(x: scale, y: scale)
        }) { (completed) in
            self.transformLimit()
        }
    }
    
    @objc func transformLimit() {
        //scale
        var s:CGFloat = 1
        if (imageView.transform.a > maxScale) {
            s = maxScale/imageView.transform.a
        }
        if (imageView.transform.a < minScale) {
            s = minScale/imageView.transform.a
        }
        
        UIView.animate(withDuration: 0.4) {
            self.imageView.transform = self.imageView.transform.scaledBy(x: s, y: s)
            if (self.imageView.transform.a <= 1) {
                self.imageView.center = CGPoint.init(x: self.view.width/2, y: self.view.height/2);
            }
            if (self.imageView.frame.origin.x > 0) {
                self.imageView.frame.origin.x = 0;
            }
            if (self.imageView.frame.origin.y > 0 ) {
                self.imageView.frame.origin.y = 0;
            }
            if (self.imageView.right < self.view.width) {
                self.imageView.right = self.view.width;
            }
            if (self.imageView.bottom < self.view.height) {
                self.imageView.bottom = self.view.height;
            }
        }
    }
    
    @objc func backToLast() {
        navigationController?.popViewController(animated: true)
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
