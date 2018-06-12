//
//  I18NManager.swift
//  DemoSet
//
//  Created by 李世远 on 2018/5/28.
//  Copyright © 2018年 Far. All rights reserved.
//

import UIKit

public let EN = "en"
public let CN = "zh-Hans"
public let KO = "ko"
public let JP = "ja"
public let LANGUAGE_SET_I18N = "language_set_i18n"

/// 国际化字符串
///
/// - Parameters:
///   - key: key
///   - table: 组 默认I18N
/// - Returns: 本地化后的字符串
public func I18NlocalizedString(key:String,table:String = "I18N") -> String{
    return I18NManager.manager.localizedString(key: key, table: table)
}

class I18NManager: NSObject {
    
    
    /// 管理器
    static let manager = I18NManager.init()
    
    
    var bundle:Bundle = Bundle.main
    var language:String = EN
    
    /// 本地化支持的语言代码
    var suportLanguagesCode:[String] {
        return [EN,CN,JP,KO]
        /*
         "en"        = "English"
         "zh-Hans"   = "简体中文"
         "ko"        = "한글"
         "ja"        = "かんご"
         */
    }
    
    /// 本地化支持的语言字符串
    var suportLanguagesString:[String] {
        var strings:[String] = []
        for code in suportLanguagesCode {
            strings.append(I18NlocalizedString(key: code))
        }
        return strings
    }
    
    override init() {
        super.init()
        initStart()
    }
    
    func initStart() {
        let cl = UserDefaults.standard.value(forKey: LANGUAGE_SET_I18N) as? String
        if cl != nil{
            self.language = cl!
        }else{
            self.language = EN
        }
        let path = Bundle.main.path(forResource: language, ofType: "lproj")
        if (path != nil) {
            bundle = Bundle.init(path: path!)!
        }
    }
    
    /// 本地化字符串
    ///
    /// - Parameters:
    ///   - key: key
    ///   - table: 本地化组
    /// - Returns: 本地化后的字符串
    func localizedString(key:String, table:String) -> String{
        return bundle.localizedString(forKey: key, value: "", table: table)
    }
    
    /// 更改语言
    func changeLanguage() {
        if language == EN {
            setLanguage(language: CN)
        }else{
            setLanguage(language: EN)
        }
    }
    
    
    /// 设置语言
    ///
    /// - Parameter index: 列表顺序
    func setLanguageIndex(index:Int) {
        if index < suportLanguagesCode.count {
            setLanguage(language: suportLanguagesCode[index])
        }
    }
    
    /// 设置语言
    ///
    /// - Parameter language: 语言
    func setLanguage(language:String) {
        if language == self.language {
            return
        }
        let path = Bundle.main.path(forResource: language, ofType: "lproj")
        if (path != nil) {
            bundle = Bundle.init(path: path!)!
        }
        self.language = language
        
        UserDefaults.standard.set(language, forKey: LANGUAGE_SET_I18N)
        UserDefaults.standard.synchronize()
        
        refreshLanguage()
    }
    
    /// 发送刷新语言的通知
    func refreshLanguage() {
        NotificationCenter.default.post(name: NSNotification.Name(LANGUAGE_SET_I18N), object: language)
    }
    
    //MARK: - Observer
    
    /// 添加刷新的通知监听，自动过滤已经添加过的
    ///
    /// - Parameters:
    ///   - observer: observe
    ///   - aSelector: selector
    func addI18NObserver(_ observer: NSObject, selector aSelector: Selector) {
        NotificationCenter.default.addObserver(observer, selector: aSelector, name: Notification.Name(LANGUAGE_SET_I18N), object: nil)
    }
    
    /// 移除对象的国际化通知监听，自动过滤未通知的对象
    ///
    /// - Parameter observer: observe
    func removeI18NObserver(_ observer: NSObject) {
        if true {
            NotificationCenter.default.removeObserver(observer, name: Notification.Name(LANGUAGE_SET_I18N), object: nil)
        }
    }

}
