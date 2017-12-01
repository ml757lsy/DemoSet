//
//  UIImage+Extension.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/9/16.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit
import MobileCoreServices

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
        
        resized = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return resized

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
    
    func creatGIF(imgs:[UIImage], duration:CGFloat, isRepeat:Bool){
        //路径
        let path = "/Users/lishiyuan/Desktop/102.gif"
        
        let url = CFURLCreateWithFileSystemPath(kCFAllocatorDefault, path as CFString, CFURLPathStyle.cfurlposixPathStyle, false)
        
        //图像目标
        let destination:CGImageDestination = CGImageDestinationCreateWithURL(url!, kUTTypeGIF, imgs.count, nil)!
        
        //设置GIF信息
        //时长
        let durationTime = NSDictionary.init(object: duration/CGFloat(imgs.count), forKey: kCGImagePropertyGIFDelayTime as! NSCopying)
        let frameProperties:NSDictionary = NSDictionary.init(object: durationTime, forKey: kCGImagePropertyGIFDictionary as! NSCopying)
        //
        let dic = NSMutableDictionary()
        dic.setObject(true, forKey: kCGImagePropertyGIFHasGlobalColorMap as! NSCopying)
        dic.setObject(kCGImagePropertyColorModelRGB, forKey: kCGImagePropertyColorModel as! NSCopying)
        dic.setObject(8, forKey: kCGImagePropertyDepth as! NSCopying)
        var repeatCount = 1
        if isRepeat {
            repeatCount = 0
        }
        dic.setObject(repeatCount, forKey: kCGImagePropertyGIFLoopCount as! NSCopying)//应该是循环次数
        //基本信息
        let gifProperties = NSDictionary.init(object: dic, forKey: kCGImagePropertyGIFDictionary as! NSCopying)
        
        for image in imgs {
            CGImageDestinationAddImage(destination, image.cgImage!, frameProperties)
        }
        CGImageDestinationSetProperties(destination, gifProperties)
        CGImageDestinationFinalize(destination)
    }
    
    /// 动图转换成图片
    ///
    /// - Parameter gifPath: 路径
    /// - Returns: 图片数组
    func gifToImages(gifPath:String) -> [UIImage] {
        
        if !FileManager.default.fileExists(atPath: gifPath) {
            print("gif path not exist")
            return []
        }
        
        var imgs:[UIImage] = []
        
        let url = URL.init(fileURLWithPath: gifPath)
        
        do {
            let data = try Data.init(contentsOf: url, options: .alwaysMapped)
            
            let source = CGImageSourceCreateWithData(data as CFData, nil)
            
            let count = CGImageSourceGetCount(source!)
            
            for i in 0..<count {
                //获取图像
                let imageRef = CGImageSourceCreateImageAtIndex(source!, i, nil)
                
                //生成image
                let image = UIImage.init(cgImage: imageRef!, scale: UIScreen.main.scale, orientation: UIImageOrientation.up)
                
                imgs.append(image)
            }
            
            return imgs
            
        } catch let error {
            print(error)
        }
        
        return imgs
    }
}
