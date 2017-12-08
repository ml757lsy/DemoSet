//
//  BannerViewController.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/10/18.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit

/// 轮播图
class BannerViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let banner = BaseBannerView.init(frame: CGRect.init(x: 10, y: 10, width: view.frame.size.width-20, height: 200))
        banner.images = ["banner1","banner2","banner3","banner4","banner5","banner6",]
        view.addSubview(banner)
        
        let w = view.width/CGFloat(banner.images.count)
        for i in 0..<banner.images.count {
            let v = UIImageView.init(frame: CGRect.init(x: CGFloat(i)*w, y: 210, width: w, height: w))
            v.image = UIImage.init(named: banner.images[i])
            view.addSubview(v)
        }
        
        let gifimage = UIImageView.init(frame: CGRect.init(x: 10, y: 220+w, width: 580/2, height: 329/2))
        gifimage.loadgif(url: URL.init(fileURLWithPath: "/Users/lishiyuan/Desktop/102.gif"))
        view.addSubview(gifimage)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
