//
//  ReaderFileCell.swift
//  DemoSet
//
//  Created by 李世远 on 2018/6/26.
//  Copyright © 2018年 Far. All rights reserved.
//

import UIKit

class ReaderFileCell: UICollectionViewCell {
    
    /// 文件名
    var string:String {
        get{
            return _str
        }
        set(newVlaue){
            _str = newVlaue
            //chai
            let paths = _str.components(separatedBy: "/")
            if paths.count > 0 {
                let name = paths.last!
                label.text = name
                //check
                if (name.containsSigns(sign: ".")){
                    //img
                    if name.hasSuffix(".jpg") || name.hasSuffix(".png") || name.hasSuffix("jpeg") || name.hasSuffix(".gif") {
                        DispatchQueue.global().async {
                            var img = UIImage.init(contentsOfFile: self._str)
                            img = img?.resize(with: .medium, size: CGSize.init(width: 120, height: 120))//缩略
                            DispatchQueue.main.async {
                                self.image.image = img
                            }
                        }
                    }
                }else{//目录
                    image.image = UIImage.init(named: "folder")
                }
            }
        }
    }
    
    private var _str = ""
    
    private let label:UILabel = UILabel()
    private let image:UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func customInit() {
        addSubview(image)
        image.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(0)
        }
        
        addSubview(label)
        label.textColor = UIColor.orange
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13)
        label.snp.makeConstraints { (make) in
            make.left.equalTo(5)
            make.right.equalTo(-5)
            make.bottom.equalTo(-2)
            make.height.equalTo(25)
        }
        //其他需要国际化的地方
        enableI18N()
    }
    
    override func refreshI18N(noti: NSNotification) {
        //
    }
    
    deinit {
        disableI18N()
    }
    
}
