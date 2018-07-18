//
//  CollectionModel.swift
//  DemoSet
//
//  Created by 李世远 on 2018/7/13.
//  Copyright © 2018年 Far. All rights reserved.
//

import UIKit

enum CollectionType {
    case none
    case water
    case fire
    case nature
}

enum CollectionClass {
    case none
    case def
    case atk
    case sup
}

enum CollectionRare {
    case nomal
    case value
    case rare
    case epic
    case legendy
    case unable
}


/// 模型
class CollectionModel: NSObject {
    
    var type:CollectionType = .none
    var clas:CollectionClass = .none
    var rare:CollectionRare = .nomal
    
    var name:String = ""
    var id:Int = 0
    var card:UIImage = UIImage.init()
    var header:UIImage = UIImage()
    
    var atk:CGFloat = 0
    var def:CGFloat = 0
    var scl:CGFloat = 0
    
    var level:Int = 0
    var atkg:CGFloat = 0
    var defg:CGFloat = 0
    var sclg:CGFloat = 0
    
    var info:String = ""
    
    
    //MARK: - func
    
    class func card(withName name:String) -> UIImage {
        let card = UIImage.init(named: name)
        if card != nil {
            return card!
        }else{
            return UIImage()
        }
    }
    
    class func box(withRare rare:CollectionRare) -> UIImage {
        var box =  UIImage.init(named: "boxImage")
        if box != nil {
            box = box?.stretchableImage(withLeftCapWidth: 140, topCapHeight: 80)
            return box!
        }else{
            return UIImage()
        }
    }
    

}
