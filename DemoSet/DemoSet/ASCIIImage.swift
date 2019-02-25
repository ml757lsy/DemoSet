//
//  ASCIIImage.swift
//  DemoSet
//
//  Created by 李世远 on 2019/2/22.
//  Copyright © 2019 Far. All rights reserved.
//

import UIKit

class ASCIIImage: NSObject {

    static let defaultTool:ASCIIImage = ASCIIImage()
    
    lazy var ascii:[String] = self.loadASCII()
    
    func str(_ image:UIImage, size:CGSize) -> String {
        
        return ""
    }
    
    fileprivate func loadASCII() -> [String] {
        
        
        return []
    }
    
    fileprivate func loadASCII(_ range: CountableClosedRange<Int>) -> [String] {
        
        let s = range.map { ascii(from: $0) }
        
        return [""]
    }
    
    /// 编号转ascii
    ///
    /// - Parameter code: int
    /// - Returns: string
    fileprivate func ascii(from code:Int) -> String {
        
        return String(Character(UnicodeScalar(code)!))
    }
    
    
    /// 计算空白像素
    ///
    /// - Parameter image: image
    /// - Returns: Int
    fileprivate func coutWhitPixInImage(_ image:UIImage) -> Int {
        
        let
        dataProvider = image.cgImage?.dataProvider,
        pixelData    = dataProvider?.data,
        pixelPointer = CFDataGetBytePtr(pixelData),
        byteCount    = CFDataGetLength(pixelData),
        pixelOffsets = stride(from: 0, to: byteCount, by: 4)
        return pixelOffsets.reduce(0) { (count, offset) -> Int in
            let
            r = pixelPointer?[offset + 0],
            g = pixelPointer?[offset + 1],
            b = pixelPointer?[offset + 2],
            isWhite = (r == 255) && (g == 255) && (b == 255)
            return isWhite ? count + 1 : count
        }
    }
    
}
