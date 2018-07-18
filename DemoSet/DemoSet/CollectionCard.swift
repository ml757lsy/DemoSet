//
//  CollectionCard.swift
//  DemoSet
//
//  Created by 李世远 on 2018/7/13.
//  Copyright © 2018年 Far. All rights reserved.
//

import UIKit
import SnapKit

class CollectionCard: UIView {
    
    private var _model:CollectionModel = CollectionModel()
    private var imageView:UIImageView = UIImageView()
    private var boxView:UIImageView = UIImageView()
    private var typeView:UIImageView = UIImageView()
    private var classView:UIImageView = UIImageView()
    private var atkLabel:UILabel = UILabel()
    private var defLabel:UILabel = UILabel()
    private var sclView:UIImageView = UIImageView()

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
        clipsToBounds = true
        
        addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.frame = bounds
        
        addSubview(boxView)
        boxView.frame = bounds
        
        addSubview(typeView)
        addSubview(classView)
        addSubview(atkLabel)
        addSubview(defLabel)
        addSubview(sclView)
    }
    
    func update() {
        imageView.image = model.card
        boxView.image = CollectionModel.box(withRare: model.rare)
    }

}
