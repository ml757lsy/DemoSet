//
//  String+GoogolExtension.swift
//  DemoSet
//
//  Created by 李世远 on 2019/1/24.
//  Copyright © 2019 Far. All rights reserved.
//

import UIKit

extension String {
    func isGoogol() -> Bool {
        for c in self {
            if c < "0" || c > "9" {
                return false
            }
        }
        return true
    }
    
    mutating func beGoogol() {
//        for i in 0..<self.lengthOfBytes(using: .utf8) {
//            let c = self.characterAt(index: i)
//            if c < "0" || c > "9" {
//                self.remove(at: String.Index.init(encodedOffset: i))
//            }
//        }
        for c in self {
            if c < "0" || c > "9" {
                self.remove(at: self.index(of: c)!)
            }
        }
    }
    
    func toIntlist() -> [Int] {
        var list:[Int] = []
        for c in self {
            list.append(c.int)
        }
        return list
    }
    
    func charcterAt(index:Int) -> Character {
        if index > self.count {
            return " "
        }
        return Character(self.substring(with: Range.init(NSRange.init(location: index, length: 1), in: self)!))
    }
    
    /// 相乘
    ///
    /// - Parameters:
    ///   - lhs: 左
    ///   - rhs: 右
    /// - Returns: 其他
    static func * (lhs: String, rhs: String) -> String {
        var list:[[Int]] = []
        for c1 in lhs {
            var nl:[Int] = []
            for c2 in rhs {
                let n = c1.int * c2.int
                nl.append(n)
            }
            list.append(nl)
        }
        
        var count:[Int] = []
        for i in 0..<list.count {
            let n = list[i]
            for j in 0..<n.count+1 {
                if j < n.count {
                    if count.count < j + i + 1 {
                        count.append(0)//填充
                    }
                    
                    count[j+i] += n[j]
                }
            }
        }
        for i in 0..<count.count {
            let n = count[count.count-i-1]
            let c = n/10;
            let index = count.count - i - 1;
            count[index] = n%10
            if index - 1 >= 0 {
                count[index-1] += c
            }else{
                if c > 0 {
                    count.insert(c, at: 0)
                }
            }
        }
        var result = ""
        for n in count {
            result.append("\(n)")
        }
        
        return result
    }
    
    /// 数字加
    ///
    /// - Parameter rhs: 另一个参数
    /// - Returns: 结果
    func add(rhs: String) -> String {
        //
        var count:[Int] = []
        var added:[Int] = []
        if self.count >= rhs.count {
            count = self.toIntlist()
            added = rhs.toIntlist()
        }else{
            count = rhs.toIntlist()
            added = self.toIntlist()
        }
        
        var c:[Int] = []
        for i in 0..<count.count {
            let index = count.count - i - 1;
            let addi = added.count - i - 1
            if addi >= 0 {
                c.append(added[addi]+count[index])
            }else{
                c.append(count[index])
            }
        }
        
        for i in 0..<c.count {
            let n = c[i]%10
            let a = c[i]/10
            c[i] = n
            if a > 0 {
                if i+1 < c.count {
                    c[i+1] += a
                }else{
                    c.append(a)
                }
            }
        }
        
        var result = ""
        for n in c.reversed() {
            result.append("\(n)")
        }
        
        return result
    }
    
    /// 减
    ///
    /// - Parameter rhs: 参数
    /// - Returns: 结果
    func minus(rhs: String) -> String {
        var sign = ""
        var big = self
        while big.hasPrefix("0") {
            big.remove(at: .init(encodedOffset: 0))
        }
        var smal = rhs
        while smal.hasPrefix("0") {
            smal.remove(at: .init(encodedOffset: 0))
        }
        if big.count < smal.count {
            sign = "-"
            let temp = big
            big = smal
            smal = temp
        }else if big.count == smal.count {
            //first
            var eql = true
            var i = 0
            while eql && i < self.count {
                
                let c1 = self.charcterAt(index: i)
                let c2 = rhs.charcterAt(index: i)
                i += 1
                if c1 < c2 {
                    big = rhs
                    smal = self
                    eql = false
                }else if c1 > c2 {
                    eql = false
                }
            }
        }
        //
        var r = 0
        var bigc = big.toIntlist()
        let smlc = smal.toIntlist()
        for i in 0..<big.count {
            let bi = big.count - i - 1
            let si = smal.count - i - 1
            if si >= 0 {
                let c1 = bigc[bi]
                let c2 = smlc[si]
                if c1+r >= c2  {
                    bigc[bi] = c1+r-c2
                    r = 0
                }else{
                    bigc[bi] = c1+r-c2+10
                    r = -1
                }
            }else{
                bigc[bi] += r
            }
        }
        var result = sign//基础符号
        for n in bigc {
            result.append("\(n)")
        }
        
        return result
    }
    
    
    /// 除法
    ///
    /// - Parameter rhs: 被除数
    /// - Returns: 结果
    func divid(rhs:String) -> String {
        
        var num = self
        let b = rhs
        var n:[Int] = []//计数
        
        for i in 0...self.count - b.count {
            //
            var end = ""
            for _ in 0..<(self.count-b.count-i) {
                end.append("0")
            }
            var r = num.minus(rhs: b+end)
            n.append(0)
            if !r.hasPrefix("-") {
//                n[i] += 1
                while !r.hasPrefix("-") {
                    n[i] += 1
                    num = r
                    r = r.minus(rhs: b+end)
                }
            }else{
                //不够补0
            }
        }
        
        print(n)
        
        var result = ""
        for i in n {
            result.append("\(i)")
        }
        
        return result
    }
}
