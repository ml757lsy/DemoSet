//
//  QRCodeModule.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/9/16.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit
import CoreGraphics

/// QRCode模块
class QRCodeModule: NSObject {

    class func initQRCode() -> UIImage {
        
        /// 1. 实例化二维码滤镜
        let filter = CIFilter(name: "CIQRCodeGenerator")///二维码
        
        /// 2. 恢复滤镜的默认属性 ///值得注意
        filter?.setDefaults()
        
        /// 3. 将字符串转换成二进制数据，（生成二维码所需的数据）
        let string = "哦哈哈，看我扫出来了什么\n像素种籽，耕耘想象\n有想象才有创造，能独立才能协作!"
        let data = string.data(using: String.Encoding.utf8)///Swift 3.0
        
        /// 4. 通过KVO把二进制数据添加到滤镜inputMessage中
        filter?.setValue(data, forKey: "inputMessage")
        filter?.setValue("H", forKey: "inputCorrectionLevel")
        
        /// 5. 获得滤镜输出的图像
        let outputImage = filter?.outputImage ///CIImage
        
        let cg = CIContext.init().createCGImage(outputImage!, from: (outputImage?.extent)!)
        let image = UIImage.init(cgImage: cg!, scale: 1, orientation: .up)
        
        return QRCodeModule.resizeImage(image: image, quality: .none, rate: 1)//选低质量就不会虚了
    }
    
    class func scaleWithFixed(width:CGFloat, image:UIImage) -> UIImage{
        let newHeight = image.size.height * (width / image.size.width)
        let size = CGSize.init(width: width, height: newHeight)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0);
    
        let context = UIGraphicsGetCurrentContext()!
    
        context.translateBy(x: 0.0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
    
        context.setBlendMode(.copy)
        context.draw(image.cgImage!, in: CGRect.init(x: 0, y: 0, width: width, height: newHeight))
    
        let imageOut = UIGraphicsGetImageFromCurrentImageContext()
    
        UIGraphicsEndImageContext();
    
        return imageOut!
    }
    
    class func resizeImage(image:UIImage, quality:CGInterpolationQuality,rate:CGFloat) -> UIImage{
        var resized:UIImage
        let width:CGFloat = image.size.width * rate
        let height:CGFloat = image.size.height * rate;
    
        UIGraphicsBeginImageContext(CGSize.init(width: width, height: height))
        let context:CGContext = UIGraphicsGetCurrentContext()!
        context.interpolationQuality = quality
        image.draw(in: CGRect.init(x: 0, y: 0, width: width, height: height))
        
        resized = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext()
        
        return resized;
    }

    class func createUIimageWithCGImage(ciImage image: CIImage, widthAndHeightValue wh: CGFloat) -> CIImage {
        let ciRect = image.extent.integral///根据容器得到适合的尺寸
        let scale = min(wh / ciRect.width, wh / ciRect.height)
        
        ///获取bitmap
        let width  = size_t(ciRect.width * scale)
        
        let height  = size_t(ciRect.height * scale)
        let cs = CGColorSpaceCreateDeviceGray()///灰度颜色通道 ///CGColorSpaceRef
        
        let info_UInt32 = CGImageAlphaInfo.none.rawValue
        let bitmapRef = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 0, space: cs, bitmapInfo: info_UInt32)
        
        let contex = CIContext(options: nil) ///  创建基于GPU的CIContext对象,性能和效果更好
        let bitmapImageRef = contex.createCGImage(image, from: CGRect(x: ciRect.origin.x, y: ciRect.origin.y, width: ciRect.size.width, height: ciRect.size.height)) ///CGImageRef
        
        ///swift 3.0, 把全局方法改为了实例方法
        bitmapRef!.interpolationQuality = CGInterpolationQuality.high///写入质量高，时间长
        bitmapRef!.scaleBy(x: scale, y: scale) ///调整“画布”的缩放
        bitmapRef?.draw(bitmapImageRef!, in: ciRect, byTiling: true)///绘制图片
        
        ///保存
        let scaledImage = bitmapRef!.makeImage() ///cgimage
        
        ///bitmapRef和bitmapImageRef不用主动释放，Core Foundation自动管理
        //let originImage = UIImage(CGImage: scaledImage!) ///原生灰度图片（灰色）
        
        let ciImage = CIImage(cgImage: scaledImage!) ///ciimage
        //let newQRCodeImage = UIImage(cgImage: scaledImage!) ///uiimage
        
        return ciImage
    }
    
    class func data(with image:UIImage) -> [[Int]]{
        // 分配内存
        let imageWidth:Int = Int(image.size.width)
        let imageHeight:Int = Int(image.size.height)
        let bytesPerRow:Int = imageWidth * 4
        let rgbImageBuf:UnsafeMutableRawPointer = malloc(bytesPerRow * imageHeight)
        
        // 创建context
        let colorSpace:CGColorSpace = CGColorSpaceCreateDeviceRGB()
        let context:CGContext = CGContext(data: rgbImageBuf, width: imageWidth, height: imageHeight, bitsPerComponent: 8, bytesPerRow: bytesPerRow, space: colorSpace,bitmapInfo: 1)!

        context.draw((image.cgImage)!, in: CGRect.init(x: 0, y: 0, width: image.size.width, height: image.size.height), byTiling: true)
        
        // 遍历像素
        var pCurPtr = rgbImageBuf
        
        var data:[[Int]] = []
        for _ in 0..<imageHeight {
            var line:[Int] = []
            for _ in 0..<imageWidth {
                let alpha = pCurPtr.load(fromByteOffset: 0, as: UInt8.self)
                let red = pCurPtr.load(fromByteOffset: 1, as: UInt8.self)
                let green = pCurPtr.load(fromByteOffset: 2, as: UInt8.self)
                let blue = pCurPtr.load(fromByteOffset: 3, as: UInt8.self)
                
                pCurPtr += 4
                var n = 0
                if (Int(red) + Int(green) + Int(blue)) < 500 {
                    n = 0
                }else{
                    n = 1
                }
                line.append(n)
            }
            data.append(line)
        }
        return data
    }
    
    
    class func other() {
        let categorys = [kCICategoryDistortionEffect,
                         kCICategoryGeometryAdjustment,
                         kCICategoryCompositeOperation,
                         kCICategoryHalftoneEffect,
                         kCICategoryColorAdjustment,
                         kCICategoryColorEffect,
                         kCICategoryTransition,
                         kCICategoryTileEffect,
                         kCICategoryGenerator,
                         kCICategoryReduction,
                         kCICategoryGradient,
                         kCICategoryStylize,
                         kCICategorySharpen,
                         kCICategoryBlur,
                         kCICategoryVideo,
                         kCICategoryStillImage,
                         kCICategoryInterlaced,
                         kCICategoryNonSquarePixels,
                         kCICategoryHighDynamicRange,
                         kCICategoryBuiltIn]
        
        var i = 0
        var j = 0
        for catename in categorys {
            i += 1
            for name in CIFilter.filterNames(inCategory: catename) {
                j += 1
                print("\(i)-\(j):"+catename+" - "+name)
            }
        }
        
        //        public let kCICategoryDistortionEffect: String ///失真效果
        //        public let kCICategoryGeometryAdjustment: String ///几何调整
        //        public let kCICategoryCompositeOperation: String ///复合操作
        //        public let kCICategoryHalftoneEffect: String ///半色调效果
        //        public let kCICategoryColorAdjustment: String ///颜色调整
        //        public let kCICategoryColorEffect: String ///颜色效果
        //        public let kCICategoryTransition: String ///翻转
        //        public let kCICategoryTileEffect: String ///瓦片效果
        //        public let kCICategoryGenerator: String ///生成器
        //        @available(iOS 5.0, *)
        //        public let kCICategoryReduction: String ///削减
        //        public let kCICategoryGradient: String ///梯度
        //        public let kCICategoryStylize: String ///风格
        //        public let kCICategorySharpen: String ///锐化
        //        public let kCICategoryBlur: String ///模糊
        //        public let kCICategoryVideo: String ///视频
        //        public let kCICategoryStillImage: String ///静态图片
        //        public let kCICategoryInterlaced: String ///交叉
        //        public let kCICategoryNonSquarePixels: String ///非方形像素
        //        public let kCICategoryHighDynamicRange: String ///高动态范围
        //        public let kCICategoryBuiltIn: String ///内建
        //        @available(iOS 9.0, *)
        //        public let kCICategoryFilterGenerator: String ///滤镜生成器
    }
}
