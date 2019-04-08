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
    
    var font:UIFont = UIFont.systemFont(ofSize: 16)
    
    lazy var ascii:[String] = self.loadASCII()
    
    //MARK: - IMAGE
    
    func str(_ image:UIImage, size:CGSize) -> String {
        let img = image.resize(with: .default, size: size),
        imgdata = img.whiteData()
        return mixImageData(imgdata)
    }
    
    func mixImageData(_ data:[[Double]]) -> String {
        let lines = data.map { mixImageDataLine($0)}
        return lines.joined()
    }
    
    func mixImageDataLine(_ line:[Double]) -> String {
        var l = ""
        _ = line.map { (d) -> String in
            let index = Int(Double(self.ascii.count - 1) * d)
            l.append(self.ascii[index])
            return l
        }
        return "\(l)\n"
    }
    
    //MARK: - ASCII
    
    /// 加载字符
    ///
    /// - Returns: 按空白排序后的字符
    fileprivate func loadASCII() -> [String] {
        
        return loadASCII(32...126)//from ' ' to '~'
    }
    
    /// 加载字符
    ///
    /// - Parameter range: 范围
    /// - Returns: 按空白排序后的字符
    fileprivate func loadASCII(_ range: CountableClosedRange<Int>) -> [String] {
        
        let sysbols = range.map { ascii(from: $0) },
            sysbolsImg = sysbols.map { UIImage.imageOfSymbol($0, self.font) },
            whitepixcount = sysbolsImg.map { coutWhitPixInImage($0) },
            sorted  = sortByIntensity(sysbols, whitepixcount)
        
        return sorted
    }
    
    /// 字符转图片
    ///
    /// - Parameters:
    ///   - ascii: 字符
    ///   - font: 字体
    /// - Returns: 图片
    fileprivate func imageOfSymbols(_ ascii:String, _ font:UIFont) -> UIImage {
        
        return UIImage()
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
    
    /// 排序
    ///
    /// - Parameters:
    ///   - symbols: 符号数组
    ///   - whitePixelCounts: 空白计数数组
    /// - Returns: 排序后的字符数组
    fileprivate func sortByIntensity(_ symbols: [String], _ whitePixelCounts: [Int]) -> [String]
    {
        let
        mappings      = NSDictionary(objects: symbols, forKeys: whitePixelCounts as [NSCopying]),
        uniqueCounts  = Set(whitePixelCounts),
        sortedCounts  = uniqueCounts.sorted(),
        sortedSymbols = sortedCounts.map { mappings[$0] as! String }
        return sortedSymbols
    }
    
}
