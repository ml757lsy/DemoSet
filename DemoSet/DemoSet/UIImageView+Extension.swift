//
//  UIImageView+Extension.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/12/7.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit

extension UIImageView {
    
     func loadgif(url:URL){
        let source = CGImageSourceCreateWithURL(url as CFURL, nil)
        
        let count = CGImageSourceGetCount(source!)
        
        var imageArray:[UIImage] = []
        var timeArray:[CGFloat] = []
        var width:CGFloat = 0
        var height:CGFloat = 0
        var duration:CGFloat = 0
        
        for i in 0..<count {
            let cg = CGImageSourceCreateImageAtIndex(source!, i, nil)
            
            let info = CGImageSourceCopyPropertiesAtIndex(source!, i, nil)
            
            let dic = info! as NSDictionary
            
            height = dic.value(forKey: "PixelHeight") as! CGFloat
            width = dic.value(forKey: "PixelWidth") as! CGFloat
            
            let gifdic = dic.value(forKey: "{GIF}") as! NSDictionary

            let time = gifdic.value(forKey: "DelayTime")

            imageArray.append(UIImage.init(cgImage: cg!))
            timeArray.append(time as! CGFloat)
            duration += time as! CGFloat
        }
        
        //系统自带动图生成，但是只有总时长的设置
        let img = UIImage.animatedImage(with: imageArray, duration: TimeInterval(duration))
        self.image = img
    }
    
}
