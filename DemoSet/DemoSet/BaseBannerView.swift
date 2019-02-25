//
//  BaseBannerView.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/10/18.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit
import WebKit

class BaseBannerView: UIView,UIScrollViewDelegate {
    
    private var localImages:[String] = []//本地图片名称
    private var onlineImages:[String] = []//在线图片地址
    private var maxNum:Int = 5//至少是3，最好是奇数
    private var index:Int = -2//中间
    private var imageviews:[UIImageView] = []
    var point = BaseBannerPointView()
    
    var bannerScroll = UIScrollView()
    
    var imageWidth:CGFloat = 1//图片宽度，默认为视图的宽度
    var imageHeight:CGFloat = 1//图片的高度，默认为视图的高度
    
    /// 完成滚动的回调
    var didEndScroll:BaseBlockInt = { _ in }
    
    
    /// 图片名称
    var images:[String] {
        get{
            return localImages
        }
        set(newValue) {
            localImages = newValue
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
        bannerScroll.showsVerticalScrollIndicator = false
        bannerScroll.showsHorizontalScrollIndicator = false
        
        for i in 0..<maxNum {
            let imageView = UIImageView.init(frame: CGRect.init(x: CGFloat(i)*bannerScroll.frame.size.width+(bannerScroll.frame.size.width-imageWidth)/2, y: (bannerScroll.frame.size.height-imageHeight)/2, width: imageWidth, height: imageHeight))
            bannerScroll.addSubview(imageView)
            imageviews.append(imageView)
        }
        
        point = BaseBannerPointView.init(frame: CGRect.init(x: width-150, y: height-10, width: 150, height: 10))
        addSubview(point)
    }
    
    private func updateImages() {
        bannerScroll.contentOffset.x = CGFloat(maxNum/2)*bannerScroll.width

        for i in 0..<imageviews.count {
            let imageview = imageviews[i]
            var n = i + index
            if n < 0 {
                n = images.count + n%maxNum
            }
            if n >= localImages.count {
                n = n%localImages.count
            }
            let name = localImages[n]
            imageview.image = UIImage.init(named: name)
        }
        //
        point.count = images.count
        var current = (index + 2)%images.count
        if current < 0 {
            current += images.count
        }
        point.changeTo(index: current)
        didEndScroll(current)
    }
    
    //MARK: - scroll delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let p = Int(scrollView.contentOffset.x/scrollView.frame.size.width)
        if p < (maxNum-1)/2{
            index -= 1
            updateImages()
        }
        if p >= (maxNum+1)/2{
            index += 1
            updateImages()
        }
    }
}
