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
public let JP = "jp"
public let LANGUAGE_SET_I18N = "language_set_i18n"

public func I18NlocalizedString(key:String,table:String = "I18N") -> String{
    return I18NManager.manager.localizedString(key: key, table: table)
}

class I18NManager: NSObject {
    
    
    
    static let manager = I18NManager.init()
    
    
    var bundle:Bundle = Bundle.main
    var language:String = EN
    
    private var i18nUIlist:[Any] = []//保存需要的控件
    
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
    
    func localizedString(key:String, table:String) -> String{
        return bundle.localizedString(forKey: key, value: "", table: table)
    }
    
    func changeLanguage() {
        if language == EN {
            setLanguage(language: CN)
        }else{
            setLanguage(language: EN)
        }
    }
    
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
    
    func refreshLanguage() {
        NotificationCenter.default.post(name: NSNotification.Name(LANGUAGE_SET_I18N), object: language)
    }
    
    //
    
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
