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
            
            var isDic:ObjCBool = false;
            if FileManager.default.fileExists(atPath: _str, isDirectory: &isDic) {
                if isDic.boolValue {
                    self.contentImg.image = UIImage.init(named: "file_folder")
                }else{
                    //check
                    if (_str.containsSigns(sign: ".")){
                        var img = UIImage.init(named: "file_search")
                        
                        //other
                        if _str.hasSuffix(".mp4") {
                            img = UIImage.init(named: "file_mp4")
                            
                        }
                        if _str.hasSuffix(".txt") {
                            img = UIImage.init(named: "file_txt")
                        }
                        if _str.hasSuffix(".pdf") {
                            img = UIImage.init(named: "file_pdf")
                        }
                        
                        self.contentImg.image = img
                        
                        //img 特殊显示
                        if _str.hasSuffix(".jpg")||_str.hasSuffix(".png")||_str.hasSuffix(".gif") {
                            DispatchQueue.global().async {
                                var img = UIImage.init(contentsOfFile: self._str)
                                var iw:CGFloat = (img?.size.width)!
                                var ih:CGFloat = (img?.size.height)!
                                if iw == 0 {
                                    iw = 1
                                }
                                if ih == 0 {
                                    ih = 1
                                }
                                
                                var w:CGFloat = 120
                                var h:CGFloat = 120
                                
                                if iw/ih > w/h {
                                    w = 120
                                    h = w * ih/iw
                                }else{
                                    h = 120
                                    w = h * iw/ih
                                }
                                
                                img = img?.resize(with: .medium, size: CGSize.init(width: w, height: h))//缩略
                                DispatchQueue.main.async {
                                    self.contentImg.image = img
                                }
                            }
                        }
                    }
                }
            }
            
            //title
            let paths = _str.components(separatedBy: "/")
            if paths.count > 0 {
                let name = paths.last!
                label.text = name
            }
        }
    }
    
    private var _str = ""
    
    private let label:UILabel = UILabel()
    private let contentImg:UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func customInit() {
        addSubview(contentImg)
        contentImg.snp.makeConstraints { (make) in
            make.width.equalTo(self.snp.height).multipliedBy(0.8).multipliedBy(0.78)
            make.height.equalTo(self.snp.height).multipliedBy(0.8)
            make.top.equalTo(2)
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
            make.height.equalTo(20)
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
