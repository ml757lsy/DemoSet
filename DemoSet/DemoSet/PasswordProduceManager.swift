//
//  PasswordProduceManager.swift
//  DemoSet
//
//  Created by lishiyuan on 2018/5/22.
//  Copyright © 2018年 Far. All rights reserved.
//

import UIKit

enum PasswordContent {
    case number
    case lower
    case upper
    case signer
    case user
}

class PasswordProduceManager: NSObject {

    static let manager = PasswordProduceManager()
    
    var users:[String] = ["ml","757","lsy","ML"]
    var signs:[String] = [".","@","$","_","%","/","|","\\","\"","-"]
    
    /*
     !" # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _` { | } ~
     */
    
    /// purenum
    ///
    /// - Parameter length: lenth
    /// - Returns: string
    func producePureNumWith(length:Int) -> String {
        
        var password = ""
        while password.count < length {
            let c = arc4random()%10
            let cc = String.init(format: "%d", c)
            password.append(cc)
        }
        
        return password
        //
        return producewith(length: length, content: [.number])
    }
    
    
    /// produce
    ///
    /// - Parameters:
    ///   - length: length
    ///   - content: content like num.lower.up or sign
    ///   - key: the word that user want to us
    ///   - userword: user`s own word
    /// - Returns: string
    func producewith(length:Int,content:[PasswordContent], key:String = "", userword:Bool = false) -> String {
        var password = ""
        
        
        
        if key.count > 0 {
            //rule
            //time
            //festive
            //color
        }
        
        if userword {
            //
        }
        
        
        while !check(string: password, content: content) {
            //until pass
            
        }
        
        return password
    }
    
    func changeCharAndNumWith(string:String) -> String {
        
        var result = ""
        
        //rule
        /* sime
         1 -> i
         2 -> L
         3 -> E
         5 -> s -> S
         6 -> b
         8 -> B
         9 -> g -> q
         0 -> o -> O
         *
         transform
         7-L
         9-6-b-p-q
         J-L
         z-N
         w-m
         W-M
         b-d
         *
         ss->55
         22->zz
         00->oo
         ll->11
         ee->33
         66->bb
         */
        
        for c in string {
            switch c {
            case "1":
                result.append("i")
                break
            case "2":
                result.append("z")
                break
            case "3":
                result.append("e")
                break
            case "5":
                result.append("s")
                break
            case "6":
                result.append("b")
                break
            case "8":
                result.append("B")
                break
            case "9":
                result.append("q")
            case "0":
                result.append("o")
            case "e":
                result.append("3")
            case "g":
                result.append("9")
            case "i":
                result.append("1")
            case "l":
                result.append("1")
            case "o":
                result.append("0")
            case "q":
                result.append("9")
            case "s":
                result.append("5")
            case "z":
                result.append("2")
            default: break
            }
        }
        
        
        
        return result
    }
    
    func check(string:String,content:[PasswordContent]) -> Bool {
        
        for cont in content {
            switch cont {
            case .number:
                if !string.containsNumber() {
                    return false
                }
                break
            case .lower:
                if !string.containsLowercased() {
                    return false
                }
                break
            case .upper:
                if !string.containsUppercased() {
                    return false
                }
                break
            case .signer:
                if !string.containsSigns(sign: signs.joined()) {
                    return false
                }
                break
            default:
                break
            }
        }
        
        return true
    }
    
}
