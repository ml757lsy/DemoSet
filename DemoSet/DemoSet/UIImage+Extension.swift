//
//  UIImage+Extension.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/9/16.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit

extension UIImage{
    func reflection(present:CGFloat) -> UIImage{
        
        let contextref = self.cgImage?.bitmapInfo
        
        return UIImage()
    }
    
    func binaryzation() -> UIImage {
        let ci = self.ciImage
        //4-53:CICategoryHalftoneEffect - CICircularScreen,CICMYKHalftone,CIDotScreen,CIHatchedScreen,CILineScreen
        let filter = CIFilter(name: "CICircularScreen")
        
        //["inputImage", "inputCenter", "inputWidth", "inputSharpness"]
        filter?.setValue(ci, forKey: "inputImage")
        filter?.setValue(CGPoint.init(x: 290, y: 165), forKey: "inputCenter")
        filter?.setValue(580, forKey: "inputWidth")
        filter?.setValue(1, forKey: "inputSharpness")
        
        let out = filter?.outputImage
        
        return UIImage.init(ciImage: out!)
    }
}
