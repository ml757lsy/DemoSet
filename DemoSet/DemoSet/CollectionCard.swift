//
//  CollectionCard.swift
//  DemoSet
//
//  Created by 李世远 on 2018/7/13.
//  Copyright © 2018年 Far. All rights reserved.
//

import UIKit

class CollectionCard: UIView {
    
    private var _model:CollectionModel = CollectionModel()
    private var imageView:UIImageView = UIImageView()
    private var boxView:UIImageView = UIImageView()
    private var typeView:UIImageView = UIImageView()
    private var classView:UIImageView = UIImageView()
    private var atkLabel:UILabel = UILabel()
    private var defLabel:UILabel = UILabel()

    var model:CollectionModel {
        get {
            return _model
        }
        set(newValue) {
            _model = newValue
            update()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        baseInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //
    func baseInit() {
        addSubview(imageView)
        addSubview(boxView)
        addSubview(typeView)
        addSubview(classView)
        addSubview(atkLabel)
        addSubview(defLabel)
    }
    
    func update() {
        
    }

}
