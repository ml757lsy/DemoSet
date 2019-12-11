//
//  UIImage+Extension.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/9/16.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVFoundation

extension UIImage{
    func reflection(present:CGFloat) -> UIImage{
        
        let contextref = self.cgImage?.bitmapInfo
        
        return UIImage()
    }
    
    /// 二值化
    ///
    /// - Returns: img
    func binaryzation() -> UIImage {
        let ci = CIImage.init(cgImage: self.cgImage!)
        
        let imageWidth = ci.extent.size.width
        let imageHeight = ci.extent.size.height
        
        //4-53:CICategoryHalftoneEffect - CICircularScreen,CICMYKHalftone,CIDotScreen,CIHatchedScreen,CILineScreen
        let filter = CIFilter(name: "CIHatchedScreen")

        //["inputImage", "inputCenter", "inputAngle", "inputWidth", "inputSharpness"]
        filter?.setValue(ci, forKey: "inputImage")
        //filter?.setValue(CGPoint.init(x: imageWidth/2, y: imageHeight/2), forKey: "inputCenter")
        filter?.setValue(2, forKey: "inputWidth")
        //filter?.setValue(0.7, forKey: "inputSharpness")
        //filter?.setValue(0, forKey: "inputAngle")
        
        let out = filter?.outputImage
        
        return UIImage.init(ciImage: out!)
    }
    
    /// 灰度化
    ///
    /// - Returns: 图
    func grayprocess() -> UIImage {
        let width = Int(self.size.width)
        let height = Int(self.size.height)
        
        let color = CGColorSpaceCreateDeviceGray()
        
        let context = CGContext.init(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 0, space: color, bitmapInfo: 1)
        context?.draw(self.cgImage!, in: CGRect.init(x: 0, y: 0, width: width, height: height))
        
        let image = UIImage.init(cgImage: (context?.makeImage())!)
        
        return image
    }
    
    ///修改RGBA值
    ///
    /// - Parameters:
    ///   - r: r 0-1
    ///   - g: g 0-1
    ///   - b: b 0-1
    ///   - a: a 0-1
    /// - Returns: img
    func rbgReset(r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat) -> UIImage {
        // 分配内存
        let imageWidth:Int = Int(self.size.width)
        let imageHeight:Int = Int(self.size.height)
        let bytesPerRow:Int = imageWidth * 4
        let rgbImageBuf:UnsafeMutableRawPointer = malloc(bytesPerRow * imageHeight)
        
        // 创建context
        
        let cg = self.cgImage
        
        
        let colorSpace:CGColorSpace = CGColorSpaceCreateDeviceRGB()
        let context:CGContext = CGContext(data: rgbImageBuf, width: imageWidth, height: imageHeight, bitsPerComponent: 8, bytesPerRow: bytesPerRow, space: colorSpace,bitmapInfo: 1)!
        
        context.draw(cg!, in: CGRect.init(x: 0, y: 0, width: self.size.width, height: self.size.height), byTiling: true)
        
        // 遍历像素
        var pCurPtr = rgbImageBuf
        for _ in 0..<imageHeight {
            for _ in 0..<imageWidth {
                var alpha = pCurPtr.load(fromByteOffset: 0, as: UInt8.self)
                var red = pCurPtr.load(fromByteOffset: 1, as: UInt8.self)
                var green = pCurPtr.load(fromByteOffset: 2, as: UInt8.self)
                var blue = pCurPtr.load(fromByteOffset: 3, as: UInt8.self)
                
                alpha = UInt8(CGFloat(alpha) * a)
                red = UInt8(CGFloat(red) * r)
                green = UInt8(CGFloat(green) * g)
                blue = UInt8(CGFloat(blue) * b)
                
                pCurPtr.storeBytes(of: alpha, toByteOffset: 0, as: UInt8.self)
                pCurPtr.storeBytes(of: red, toByteOffset: 1, as: UInt8.self)
                pCurPtr.storeBytes(of: green, toByteOffset: 2, as: UInt8.self)
                pCurPtr.storeBytes(of: blue, toByteOffset: 3, as: UInt8.self)
                
                pCurPtr += 4
            }
        }
        let image = UIImage.init(cgImage: (context.makeImage())!)
        
        return image
    }
    
    //MARK: - resize
    
    /// 比例缩放
    ///
    /// - Parameters:
    ///   - quality: 质量
    ///   - rate: 比例
    /// - Returns: img
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
    
    /// 缩放至大小
    ///
    /// - Parameters:
    ///   - quality: 质量
    ///   - size: 大小
    /// - Returns: 图片
    func resize(with quality:CGInterpolationQuality,size:CGSize) -> UIImage {
        var resized:UIImage
        let width:CGFloat = size.width
        let height:CGFloat = size.height
        
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
                    row.append(1)
                }else{
                    row.append(0)
                }
                
                pCurPtr += 4
            }
            data.append(row)
        }

        
        return data
    }
    
    /// 根据数据生成图
    ///
    /// - Parameters:
    ///   - data: 数据
    ///   - pixSize: 像素大小
    /// - Returns: img
    class func creatImage(with data:[[Int]], pixSize:CGFloat) -> UIImage {
        
        let imageWidth = data[0].count
        let imageHeight = data.count
        
        let color = CGColorSpaceCreateDeviceRGB()
        let bytesPerRow:Int = imageWidth * 4
        let rgbImageBuf:UnsafeMutableRawPointer = malloc(bytesPerRow * imageHeight)
        
        let context = CGContext.init(data: rgbImageBuf, width: imageWidth, height: imageHeight, bitsPerComponent: 8, bytesPerRow: bytesPerRow, space: color, bitmapInfo: 1)
        
        var pCurPtr = rgbImageBuf
        for l in 0..<imageHeight {
            for w in 0..<imageWidth {
                let d = data[l][w]
                pCurPtr.storeBytes(of: 255, toByteOffset: 0, as: UInt8.self)
                if d == 0 {
                    
                }else{
                    pCurPtr.storeBytes(of: 255, toByteOffset: 1, as: UInt8.self)//r
                    pCurPtr.storeBytes(of: 255, toByteOffset: 2, as: UInt8.self)//g
                    pCurPtr.storeBytes(of: 255, toByteOffset: 3, as: UInt8.self)//b
                }
                pCurPtr += 4
            }
        }
        
        return UIImage.init(cgImage: (context?.makeImage())!)
    }
    
    /// 加载图片
    ///
    /// - Parameter path: 路径
    /// - Returns: 图片 识别gif与普通
    class func contentsOfFile(path: String) -> UIImage? {
        if path.lowercased().hasSuffix(".gif") {
            return loadgif(url: URL.init(fileURLWithPath: path))
        }else{
            return UIImage.init(contentsOfFile: path)
        }
    }
    
    /// 获取主色调
    ///
    /// - Returns: uicolor
    func mainColor() -> UIColor {
        // 分配内存
        let imageWidth:Int = 40
        let imageHeight:Int = 40
        let bytesPerRow:Int = imageWidth * 4
        let rgbImageBuf:UnsafeMutableRawPointer = malloc(bytesPerRow * imageHeight)
        
        //resize
        let little = self.resize(with: .high, size: CGSize.init(width: imageWidth, height: imageHeight))
        
        // 创建context
        let cg = little.cgImage
        
        let colorSpace:CGColorSpace = CGColorSpaceCreateDeviceRGB()
        let context:CGContext = CGContext(data: rgbImageBuf, width: imageWidth, height: imageHeight, bitsPerComponent: 8, bytesPerRow: bytesPerRow, space: colorSpace,bitmapInfo: 1)!
        
        context.draw(cg!, in: CGRect.init(x: 0, y: 0, width: imageWidth, height: imageHeight), byTiling: true)
        
        let set:NSCountedSet = NSCountedSet.init()
        // 遍历像素
        var pCurPtr = rgbImageBuf
        for _ in 0..<imageHeight {
            for _ in 0..<imageWidth {
                let alpha = pCurPtr.load(fromByteOffset: 0, as: UInt8.self)
                let red = pCurPtr.load(fromByteOffset: 1, as: UInt8.self)
                let green = pCurPtr.load(fromByteOffset: 2, as: UInt8.self)
                let blue = pCurPtr.load(fromByteOffset: 3, as: UInt8.self)
                
                let ar = [alpha,red,green,blue]
                set.add(ar)
                
                pCurPtr += 4
            }
        }
        var maxa:[UInt8] = [0,255,255,255]
        var max:Int = 0
        for a in set {
            let c = set.count(for: a)
            if c > max {
                max = c
                maxa = a as! [UInt8]
            }
        }
        
        let a = CGFloat(maxa[0])/255.0
        let r = CGFloat(maxa[1])/255.0
        let g = CGFloat(maxa[2])/255.0
        let b = CGFloat(maxa[3])/255.0
        
        return UIColor.init(red: a, green: r, blue: g, alpha: b)
    }
    
    //MARK: - GIF
    
    /// 加载动图
    ///
    /// - Parameter url: 路径
    /// - Returns: 图
    class func loadgif(url:URL) -> UIImage?{
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
        return img
    }
    
    /// 创建动图
    ///
    /// - Parameters:
    ///   - imgs: 图组
    ///   - duration: 持续时间
    ///   - isRepeat: 是否重复
    class func creatGIF(imgs:[UIImage], duration:CGFloat, isRepeat:Bool){
        //路径
        let path = NSHomeDirectory().appending("Documents/1.gif")
        
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
                let image = UIImage.init(cgImage: imageRef!, scale: UIScreen.main.scale, orientation: UIImage.Orientation.up)
                
                imgs.append(image)
            }
            
            return imgs
            
        } catch let error {
            print(error)
        }
        
        return imgs
    }
    
    //MARK： -
    func getCIImage() -> CIImage {
        if ciImage != nil {
            return ciImage!
        }else{
            let ci = CIImage.init(cgImage: cgImage!)
            return ci
        }
    }
    
    func getCGImage() -> CGImage {
        if cgImage != nil {
            return cgImage!
        }else{
            let ci = self.ciImage
            let context = CIContext.init()
            let cg = context.createCGImage(ci!, from: (ci?.extent)!)
            return cg!
        }
    }
    
    /// 将gif图片转换成mp4格式便于播放
    ///
    /// - Parameters:
    ///   - gifPath: gif路径
    ///   - videoPath: 生成的video路径
    ///   - duration: 时长
    ///   - completion: 完成的回调
    class func gifToVideo(gifPath:String, videoPath:String, duration:TimeInterval, completion:@escaping(Bool)->Void) {
        let gifimgs = UIImage().gifToImages(gifPath: gifPath)
        let size = gifimgs[0].size
        let w = size.width
        let h = size.height
        
        do {
            let videourl = URL.init(fileURLWithPath: videoPath)
            let videoWriter = try AVAssetWriter.init(url: videourl, fileType: .mp4)
            let setting = [AVVideoCodecKey:"AVVideoCodecTypeH264",AVVideoWidthKey:NSNumber.init(value: Float(w)),AVVideoHeightKey:NSNumber.init(value: Float(h))] as [String : Any]
            let videoInput = AVAssetWriterInput.init(mediaType: .video, outputSettings: setting)
            
            var index = 0
            let queue = DispatchQueue.init(label: "mediainput")
            let frameDuration = Int64(duration/TimeInterval(gifimgs.count)*1000)
            videoInput.requestMediaDataWhenReady(on: queue) {
                //
                let adaptor = AVAssetWriterInputPixelBufferAdaptor.init(assetWriterInput: videoInput, sourcePixelBufferAttributes: nil)
                var finished = true
                
                while index < gifimgs.count {
                    if !videoInput.isReadyForMoreMediaData {
                        finished = false
                        break
                    }
                    
                    let img = gifimgs[index]
                    let buffer = UIImage().CVPixelBufferRefFromImage(img: img)
                    let time = CMTime.init(value: frameDuration*Int64(index), timescale: 1000)
                    let addResult = adaptor.append(buffer, withPresentationTime: time)
                    
                    if addResult {
                        index += 1
                    }else {
                        print("add img:\(index) fail")
                    }
                }
                
                if finished {
                    videoInput.markAsFinished()
                    videoWriter.finishWriting {
                        DispatchQueue.main.async {
                            completion(true)
                        }
                    }
                }else {
                    completion(false)
                    print("trans 2 video fail")
                }
                
            }
        } catch let error {
            print(error)
            completion(false)
        }
        
        
    }
    
    /// 图片转cvpixbuffer
    ///
    /// - Parameter img: uiimage
    /// - Returns: buffer
    func CVPixelBufferRefFromImage (img:UIImage) -> CVPixelBuffer {
        
        let size = img.size
        let image = img.cgImage!
        
        let options = [kCVPixelBufferCGImageCompatibilityKey:NSNumber.init(value: true),kCVPixelBufferCGBitmapContextCompatibilityKey:nil]
        
        var pxbuffer:CVPixelBuffer? = nil;
        let status:CVReturn = CVPixelBufferCreate(kCFAllocatorDefault, Int(size.width), Int(size.height), kCVPixelFormatType_32ABGR, options as CFDictionary, &pxbuffer)
        
        if !(status == kCVReturnSuccess && pxbuffer != nil) {
            print("pxbuffer create error!!!")
        }
        
        CVPixelBufferLockBaseAddress(pxbuffer!, []);
        let pxdata = CVPixelBufferGetBaseAddress(pxbuffer!);
        
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB();
        
        //CGBitmapInfo的设置
        //uint32_t bitmapInfo = CGImageAlphaInfo | CGBitmapInfo;
        
        //当inputPixelFormat=kCVPixelFormatType_32BGRA CGBitmapInfo的正确的设置
        //uint32_t bitmapInfo = kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrder32Host;
        //uint32_t bitmapInfo = kCGImageAlphaNoneSkipFirst | kCGBitmapByteOrder32Host;
        
        //当inputPixelFormat=kCVPixelFormatType_32ARGB CGBitmapInfo的正确的设置
        //uint32_t bitmapInfo = kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrder32Big;
        //uint32_t bitmapInfo = kCGImageAlphaNoneSkipFirst | kCGBitmapByteOrder32Big;
        
        let bitmapInfo = CGBitmapInfo.alphaInfoMask.rawValue | CGBitmapInfo.byteOrder32Big.rawValue;
        
        let context = CGContext(data: pxdata, width: Int(size.width), height: Int(size.height), bitsPerComponent: 8, bytesPerRow: 4*Int(size.width), space: rgbColorSpace, bitmapInfo: bitmapInfo);
        context?.draw(image, in: CGRect.init(x: 0, y: 0, width: size.width, height: size.height))
        
        CVPixelBufferUnlockBaseAddress(pxbuffer!, []);
        
        return pxbuffer!;
    }
    
    //MARK: - Data
    
    /// 图转数据
    ///
    /// - Parameter img: image
    /// - Returns: base64
    func imageEncryptToData(img:UIImage) -> Data {
        let data = img.pngData()
        return (data?.base64EncodedData())!
    }
    
    /// 数据转图
    ///
    /// - Parameter data: base64
    /// - Returns: image
    func imageEncryptWithData(data:Data) -> UIImage {
        return UIImage.init(data: Data.init(base64Encoded: data)!)!
    }
    
    //MARK: - CharMap
    
    /// 生成字符图
    ///
    /// - Parameters:
    ///   - chars: 字符范围
    ///   - width: 字符宽度
    /// - Returns: [[char]]
    func charMap(with chars:[Character],width:Int) -> [[Character]] {
        var pixmap:[[UInt8]] = []//pix
        
        
        return [[]]
    }
    
    func charSort(chars:[Character], size:CGSize) -> [[UInt8]]{
        //各点差值法
        
        //1.各字符按这个size生成表
        let count = chars.map { $0 }
        
        return []
    }
    
    func charImage(symbol:String, font:UIFont) -> UIImage {
        let
        length = font.pointSize * 2,
        size   = CGSize(width: length, height: length),
        rect   = CGRect(origin: CGPoint.zero, size: size)
        
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        
        // Fill the background with white.
        context?.setFillColor(UIColor.white.cgColor)
        context?.fill(rect)
        
        // Draw the character with black.
        let nsString = NSString(string: symbol)
        nsString.draw(at: rect.origin, withAttributes: convertToOptionalNSAttributedStringKeyDictionary([
            convertFromNSAttributedStringKey(NSAttributedString.Key.font): font,
            convertFromNSAttributedStringKey(NSAttributedString.Key.foregroundColor): UIColor.black
            ]))
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    
    func charWithBloc(block:[[UInt8]]) -> Character {
        
        return "a"
    }
    
//     Helper function inserted by Swift 4.2 migrator.
    fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
        guard let input = input else { return nil }
        return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
    }

    // Helper function inserted by Swift 4.2 migrator.
    fileprivate func convertFromNSAttributedStringKey(_ input: NSAttributedString.Key) -> String {
        return input.rawValue
    }
}
