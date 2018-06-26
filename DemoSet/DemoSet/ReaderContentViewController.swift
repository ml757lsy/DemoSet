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
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        if files.count > 0 {
            imageView.image = UIImage.init(contentsOfFile: files[current])
        }
        
        let swipleft = UISwipeGestureRecognizer.init(target: self, action: #selector(swipe(ges:)))
        swipleft.direction = .left
        imageView.addGestureRecognizer(swipleft)
        let swipright = UISwipeGestureRecognizer.init(target: self, action: #selector(swipe(ges:)))
        swipright.direction = .right
        imageView.addGestureRecognizer(swipright)
        
        let pin = UIPinchGestureRecognizer.init(target: self, action: #selector(pine(ges:)))
        imageView.addGestureRecognizer(pin)
        
        let back = UIButton.init(type: .system)
        back.setTitle("返回", for: .normal)
        back.frame = CGRect.init(x: 0, y: 0, width: 44, height: 44)
        back.addTarget(self, action: #selector(backToLast), for: .touchUpInside)
        
        let right = UIBarButtonItem.init(customView: back)
        navigationItem.rightBarButtonItem = right
        
    }
    
    func swipe(ges:UISwipeGestureRecognizer) {
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
        imageView.image = UIImage.init(contentsOfFile: files[current])
    }
    
    func pine(ges:UIPinchGestureRecognizer) {
        var scale = ges.scale
        if scale > 3 {
            scale = 3
        }
        if scale < 0.7 {
            scale = 0.7
        }
        imageView.transform = CGAffineTransform.init(scaleX: ges.scale, y: ges.scale)
    }
    
    func backToLast() {
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
