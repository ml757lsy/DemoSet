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
        banner.images = ["b1","b2","b3","b4","b5","b6"]
        var colors = [UIColor.white,UIColor.white,UIColor.white,UIColor.white,UIColor.white,UIColor.white]
        banner.didEndScroll = {
            index in
            //
            var color = colors[index]
            if (color == UIColor.white) {
                color = (UIImage.init(named: banner.images[index])?.mainColor())!
                colors[index] = color
            }
            UIView.animate(withDuration: 0.4, animations: {
                self.view.backgroundColor = color
            })
        }
        view.addSubview(banner)
        
        let w = view.width/CGFloat(banner.images.count)
        for i in 0..<banner.images.count {
            let v = UIImageView.init(frame: CGRect.init(x: CGFloat(i)*w, y: 210, width: w, height: w))
            v.image = UIImage.init(named: banner.images[i])
            view.addSubview(v)
        }
        
        let gifimage = UIImageView.init(frame: CGRect.init(x: 10, y: 220+w, width: 580/2, height: 329/2))
        let path = Bundle.main.path(forResource: "testGif", ofType: "gif")
        gifimage.loadgif(url: URL.init(fileURLWithPath: path!))
        view.addSubview(gifimage)
        
        var gw:CGFloat = (gifimage.image?.size.width)!
        var gh:CGFloat = (gifimage.image?.size.height)!
        
        if gw > SCREENWIDTH - 20 {
            let scal = (SCREENWIDTH - 20)/gw
            gh = gh * scal
            gw = SCREENWIDTH - 20
        }
        gifimage.frame.size.width = gw
        gifimage.frame.size.height = gh
        
        //
        perform(#selector(giftovideo), with: nil, afterDelay: 1)
    }
    
    @objc func giftovideo() {
        let gifpath = Bundle.main.path(forResource: "4da0e35c49aa37b70fd54a5b92447df0d9c259661a9865-t8562E_fw658", ofType: "gif")
        var path = NSHomeDirectory()
        path.append("/Documents")
        path.append("/test.mp4")
        let videopath = path
        UIImage.gifToVideo(gifPath: gifpath!, videoPath: videopath, duration: 4) {
            result in
            print("complate")
        }
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
