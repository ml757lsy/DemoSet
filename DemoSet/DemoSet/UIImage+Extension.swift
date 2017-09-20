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
        let ci = CIImage.init(cgImage: self.cgImage!)
        
        let imageWidth = ci.extent.size.width
        let imageHeight = ci.extent.size.height
        
        //4-53:CICategoryHalftoneEffect - CICircularScreen,CICMYKHalftone,CIDotScreen,CIHatchedScreen,CILineScreen
        let filter = CIFilter(name: "CIDotScreen")

        //["inputImage", "inputCenter", "inputAngle", "inputWidth", "inputSharpness"]
        filter?.setValue(ci, forKey: "inputImage")
        //filter?.setValue(CGPoint.init(x: imageWidth/2, y: imageHeight/2), forKey: "inputCenter")
        filter?.setValue(2, forKey: "inputWidth")
        //filter?.setValue(0.7, forKey: "inputSharpness")
        //filter?.setValue(0, forKey: "inputAngle")
        
        let out = filter?.outputImage
        
        return UIImage.init(ciImage: out!)
    }
    
    func resize(with quality:CGInterpolationQuality,rate:CGFloat) -> UIImage {
        var resized:UIImage
        let width:CGFloat = self.size.width * rate
        let height:CGFloat = self.size.height * rate;
        
        UIGraphicsBeginImageContext(CGSize.init(width: width, height: height))
        let context:CGContext = UIGraphicsGetCurrentContext()!
        context.interpolationQuality = quality
        self.draw(in: CGRect.init(x: 0, y: 0, width: width, height: height))
        
        resized = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext()
        
        return resized;

    }
    
    func black() -> [[Int]] {
        // 分配内存
        let imageWidth:Int = Int(self.size.width)
        let imageHeight:Int = Int(self.size.height)
        let bytesPerRow:Int = imageWidth * 4
        let rgbImageBuf:UnsafeMutableRawPointer = malloc(bytesPerRow * imageHeight)
        
        // 创建context
        
        let cicontext = CIContext.init()
        
        let cg = cicontext.createCGImage(self.ciImage!, from: (self.ciImage?.extent)!)
        
        
        let colorSpace:CGColorSpace = CGColorSpaceCreateDeviceRGB()
        let context:CGContext = CGContext(data: rgbImageBuf, width: imageWidth, height: imageHeight, bitsPerComponent: 8, bytesPerRow: bytesPerRow, space: colorSpace,bitmapInfo: 1)!
        
        context.draw(cg!, in: CGRect.init(x: 0, y: 0, width: self.size.width, height: self.size.height), byTiling: true)
        
        // 遍历像素
        var pCurPtr = rgbImageBuf
        var data:[[Int]] = []
        for _ in 0..<imageHeight {
            var row:[Int] = []
            for _ in 0..<imageWidth {
                let alpha = pCurPtr.load(fromByteOffset: 0, as: UInt8.self)
                let red = pCurPtr.load(fromByteOffset: 1, as: UInt8.self)
                let green = pCurPtr.load(fromByteOffset: 2, as: UInt8.self)
                let blue = pCurPtr.load(fromByteOffset: 3, as: UInt8.self)
                
                if red/3 + green/3 + blue/3 < 255 {
                    row.append(0)
                }else{
                    row.append(1)
                }
                
                pCurPtr += 4
            }
            data.append(row)
        }

        
        return data
    }
}
