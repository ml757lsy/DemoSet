//
//  BaseBannerView.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/10/18.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit

class BaseBannerView: UIView {
    
    var loaclImages:[String] = []//本地图片名称
    var onlineImages:[String] = []//在线图片地址
    
    var bannerScroll = UIScrollView()
    
    var imageWidth:CGFloat = 1//图片宽度，默认为视图的宽度
    var imageHeight:CGFloat = 1//图片的高度，默认为视图的高度

    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //
    func initView() {
        imageWidth = frame.size.width
        imageHeight = frame.size.height
        //
        addSubview(bannerScroll)
        bannerScroll.frame = self.bounds
        bannerScroll.isPagingEnabled = true
        bannerScroll.contentSize = CGSize.init(width: imageWidth, height: frame.size.height)
    }
}
