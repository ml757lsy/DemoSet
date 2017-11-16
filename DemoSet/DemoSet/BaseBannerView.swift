//
//  BaseBannerView.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/10/18.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit

class BaseBannerView: UIView,UIScrollViewDelegate {
    
    private var loaclImages:[String] = []//本地图片名称
    private var onlineImages:[String] = []//在线图片地址
    private var maxNum:Int = 5//至少是3，最好是奇数
    
    var bannerScroll = UIScrollView()
    
    var imageWidth:CGFloat = 1//图片宽度，默认为视图的宽度
    var imageHeight:CGFloat = 1//图片的高度，默认为视图的高度
    
    
    /// 图片名称
    var images:[String] {
        get{
            return loaclImages
        }
        set(newValue) {
            loaclImages = images
            updateImages()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //
    func initView() {
        imageWidth = frame.size.width-20
        imageHeight = frame.size.height-10
        //
        addSubview(bannerScroll)
        bannerScroll.frame = self.bounds
        bannerScroll.isPagingEnabled = true
        bannerScroll.contentSize = CGSize.init(width: frame.size.width*CGFloat(maxNum), height: frame.size.height)
        bannerScroll.delegate = self
        bannerScroll.backgroundColor = UIColor.yellow
        
        for i in 0..<maxNum {
            let imageView = UIImageView.init(frame: CGRect.init(x: CGFloat(i)*bannerScroll.frame.size.width+(bannerScroll.frame.size.width-imageWidth)/2, y: (bannerScroll.frame.size.height-imageHeight)/2, width: imageWidth, height: imageHeight))
            imageView.backgroundColor = UIColor.randomColor()
            bannerScroll.addSubview(imageView)
        }
    }
    
    private func updateImages() {
        
    }
    
    //MARK: - scroll delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x <= CGFloat(maxNum/2)*scrollView.frame.size.width {
            //left
            print("left")
        }else if scrollView.contentOffset.x >= (CGFloat(maxNum/2)+1)*scrollView.frame.size.width {
            //right
            print("Right")
        }
    }
}
