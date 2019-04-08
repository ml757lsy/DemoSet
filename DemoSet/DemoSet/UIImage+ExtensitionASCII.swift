//
//  UIImage+ExtensitionASCII.swift
//  DemoSet
//
//  Created by 李世远 on 2019/3/29.
//  Copyright © 2019 Far. All rights reserved.
//

import AVFoundation
import Foundation
import UIKit

extension UIImage
{
    class func imageOfSymbol(_ symbol: String, _ font: UIFont) -> UIImage
    {
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
    
    func imageConstrainedToMaxSize(_ maxSize: CGSize) -> UIImage
    {
        let isTooBig =
            size.width  > maxSize.width ||
                size.height > maxSize.height
        if isTooBig
        {
            let
            maxRect       = CGRect(origin: CGPoint.zero, size: maxSize),
            scaledRect    = AVMakeRect(aspectRatio: self.size, insideRect: maxRect),
            scaledSize    = scaledRect.size,
            targetRect    = CGRect(origin: CGPoint.zero, size: scaledSize),
            width         = Int(scaledSize.width),
            height        = Int(scaledSize.height),
            cgImage       = self.cgImage,
            bitsPerComp   = cgImage?.bitsPerComponent,
            compsPerPixel = 4, // RGBA
            bytesPerRow   = width * compsPerPixel,
            colorSpace    = cgImage?.colorSpace,
            bitmapInfo    = cgImage?.bitmapInfo,
            context       = CGContext(
                data: nil,
                width: width,
                height: height,
                bitsPerComponent: bitsPerComp!,
                bytesPerRow: bytesPerRow,
                space: colorSpace!,
                bitmapInfo: (bitmapInfo?.rawValue)!)
            
            if context != nil
            {
                context!.interpolationQuality = CGInterpolationQuality.low
                context?.draw(cgImage!, in: targetRect)
                if let scaledCGImage = context?.makeImage()
                {
                    return UIImage(cgImage: scaledCGImage)
                }
            }
        }
        return self
    }
    
    func imageRotatedToPortraitOrientation() -> UIImage
    {
        let mustRotate = self.imageOrientation != .up
        if mustRotate
        {
            let rotatedSize = CGSize(width: size.height, height: size.width)
            UIGraphicsBeginImageContext(rotatedSize)
            if let context = UIGraphicsGetCurrentContext()
            {
                // Perform the rotation and scale transforms around the image's center.
                context.translateBy(x: rotatedSize.width/2, y: rotatedSize.height/2)
                
                // Rotate the image upright.
                let
                degrees = self.degreesToRotate(),
                radians = degrees * M_PI / 180.0
                context.rotate(by: CGFloat(radians))
                
                // Flip the image on the Y axis.
                context.scaleBy(x: 1.0, y: -1.0)
                
                let
                targetOrigin = CGPoint(x: -size.width/2, y: -size.height/2),
                targetRect   = CGRect(origin: targetOrigin, size: self.size)
                
                context.draw(self.cgImage!, in: targetRect)
                let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()!
                UIGraphicsEndImageContext()
                
                return rotatedImage
            }
        }
        return self
    }
    
    fileprivate func degreesToRotate() -> Double
    {
        switch self.imageOrientation
        {
        case .right: return  90
        case .down:  return 180
        case .left:  return -90
        default:     return   0
        }
    }
    
    /// 图片的白值计算
    ///
    /// - Returns: [[Double]] 0-1
    func whiteData() -> [[Double]] {
        // 分配内存
        let imageWidth:Int = Int(self.size.width)
        let imageHeight:Int = Int(self.size.height)
        let bytesPerRow:Int = imageWidth * 4
        let rgbImageBuf:UnsafeMutableRawPointer = malloc(bytesPerRow * imageHeight)
        
        // 创建context
        
        var cg = self.cgImage
        
        if (cg == nil) {
            let cicontext = CIContext.init()
            
            cg = cicontext.createCGImage(self.ciImage!, from: (self.ciImage?.extent)!)
        }else{
            cg = cg!
        }
        
        let colorSpace:CGColorSpace = CGColorSpaceCreateDeviceRGB()
        let context:CGContext = CGContext(data: rgbImageBuf, width: imageWidth, height: imageHeight, bitsPerComponent: 8, bytesPerRow: bytesPerRow, space: colorSpace,bitmapInfo: 1)!
        
        context.draw(cg!, in: CGRect.init(x: 0, y: 0, width: self.size.width, height: self.size.height), byTiling: true)
        
        // 遍历像素
        var pCurPtr = rgbImageBuf
        var data:[[Double]] = []
        for _ in 0..<imageHeight {
            var row:[Double] = []
            for _ in 0..<imageWidth {
                let alpha = pCurPtr.load(fromByteOffset: 0, as: UInt8.self)
                let red = pCurPtr.load(fromByteOffset: 1, as: UInt8.self)
                let green = pCurPtr.load(fromByteOffset: 2, as: UInt8.self)
                let blue = pCurPtr.load(fromByteOffset: 3, as: UInt8.self)
                
                let
                redWeight   = 0.229,
                greenWeight = 0.587,
                blueWeight  = 0.114,
                weightedMax = 255.0 * redWeight   +
                    255.0 * greenWeight +
                    255.0 * blueWeight,
                weightedSum = Double(red) * redWeight   +
                    Double(green) * greenWeight +
                    Double(blue) * blueWeight
                
                row.append(weightedSum/weightedMax)
                
                pCurPtr += 4
            }
            data.append(row)
        }
        return data
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
    guard let input = input else { return nil }
    return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromNSAttributedStringKey(_ input: NSAttributedString.Key) -> String {
    return input.rawValue
}
