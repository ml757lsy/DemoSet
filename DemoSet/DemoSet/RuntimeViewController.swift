//
//  RuntimeViewController.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/12/22.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit

// 运行时相关操作的实现
class RuntimeClass {
    @objc var name:String = "Yoah class"
    let age:Int = 10
    var info:AnyObject? = nil
    
    func sayHello() {
        print("\(#function, #line)")
    }
}

class RuntimeViewController: BaseViewController {
    
    var name:String = "Jhon controller"
    let age:Int = 10
    var info:AnyObject? = nil
    
    var infoText:UITextView = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        infoText.frame = CGRect.init(x: 10, y: 10, width: SCREENWIDTH-20, height: SCREENHEIGHT-64-49)
        view.addSubview(infoText)
        
        print("======Runtime Start======")
        getMethodAndPropertiesFrom(clas: RuntimeClass)
        getMethodAndPropertiesFrom(clas: RuntimeViewController)
        
        swizzleMethod(clas: RuntimeViewController, originMethod: #selector(viewDidAppear(_:)), destinationMethod: #selector(m_viewDidAppear(_:)))
        swizzleMethod(clas: RuntimeViewController, originMethod: #selector(returnInt), destinationMethod: #selector(m_returnInt))
        
        returnInt()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("Origin Did")
        infoText.text.append("\nOrigin Did")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func m_viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("My Did")
        infoText.text.append("\nMy Did")
    }
    
    dynamic func returnInt() -> Int  {
        print("ReturnInt")
        infoText.text.append("\nReturnInt")
        return 1
    }
    
    func m_returnInt() -> Int {
        print("M_ReturnInt")
        infoText.text.append("\nM_ReturnInt")
        return 2
    }
    
    func returnValue() -> (Int, Bool, String) {
        return (1, true, "value")
    }
    
    func getMethodAndPropertiesFrom(clas:AnyClass) {
        print("Method")
        infoText.text.append("\nMethod")
        var methodNum:UInt32 = 0
        let methods = class_copyMethodList(clas, &methodNum)
        
        for index in 0..<numericCast(methodNum) {
            let m:Method = methods![index]!
            
            print("m_name:\(method_getName(m))")
            print("m_returntype\(String.init(utf8String: method_copyReturnType(m)))")
            print("m_type\(String.init(utf8String: method_getTypeEncoding(m)))")
            
            infoText.text.append("\nm_name:\(method_getName(m))")
            infoText.text.append("\nm_returntype\(String.init(utf8String: method_copyReturnType(m)))")
            infoText.text.append("\nm_type\(String.init(utf8String: method_getTypeEncoding(m)))")
        }
        //
        print("Properties")
        infoText.text.append("\nProperties")
        var propNum:UInt32 = 0
        let properties = class_copyPropertyList(clas, &propNum)
        
        for index in 0..<numericCast(propNum) {
            let p:objc_property_t = properties![index]!
            
            let name = String.init(utf8String: property_getName(p))
            print("p_name:\(name)")
            print("p_attribute:\(String.init(utf8String: property_getAttributes(p)))")
            
            let value = "clas.vale"
            print("value:\(value)")
            
            infoText.text.append("\np_name:\(name)")
            infoText.text.append("\np_attribute:\(String.init(utf8String: property_getAttributes(p)))")
            infoText.text.append("\nvalue:\(value)")
        }
        print("--------")
        infoText.text.append("\n--------")
        /*
         v means void return type
         12 means the size of the argument frame (12 bytes)
         @0 means that there is an Objective-C object type at byte offset 0 of the argument frame (this is the implicit self object in each Objective-C method)
         :4 means that there is a selector at byte offset 4 (this is the implicit _cmd in every method, which is the selector that was used to invoke the method).
         @8 means that there is another Objective-C object type at byte offset 8.
         */
    }
    
    func swizzleMethod(clas:AnyClass, originMethod:Selector, destinationMethod:Selector) {
        let origin = class_getInstanceMethod(clas, originMethod)
        let swizzle = class_getInstanceMethod(clas, destinationMethod)
        
        method_exchangeImplementations(origin, swizzle)
    }
    
}
