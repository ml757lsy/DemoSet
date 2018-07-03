//
//  PlayerManager.swift
//  DemoSet
//
//  Created by 李世远 on 2018/6/28.
//  Copyright © 2018年 Far. All rights reserved.
//

import UIKit
import AVKit

/// 管理器
class PlayerManager: NSObject {
    
    // 单例就只有一个了，不太适合
    
    private var player = AVPlayer()
    private var layer = AVPlayerLayer.init()
    var view = PlayerView()
    
    override init() {
        super.init()
        layer.player = player
        layer.videoGravity = AVLayerVideoGravityResizeAspect
        layer.contentsScale = 1.0
        view.playerLayer = layer
    }
    
    func loadVideo(with url:String) {
        let path = URL.init(fileURLWithPath: url)
        let item = AVPlayerItem.init(url: path)
        print(item.asset)
        
        player = AVPlayer.init(playerItem: item)
        layer.player = player
        player.play()
    }
    
    func stop() {
        player.pause()
        view.stop()
    }
    
}

/// 视图 比layer可以更好的自适应
class PlayerView: UIView {
    
    private var _layer = AVPlayerLayer()
    private var _timer = Timer()
    private var _timeCout:Int = 0
    
    var playerLayer:AVPlayerLayer{
        get{
            return _layer
        }
        set(newVlaue) {
            _layer.removeFromSuperlayer()
            _layer = newVlaue
            layer.addSublayer(newVlaue)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initControl()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = layer.bounds
    }
    
    func stop() {
        _timer.invalidate()
    }
    
    /// 创建控制器相关组件
    func initControl() {
        //slider
        let slider = UISlider.init(frame: CGRect.init(x: 0, y: 0, width: 10, height: 10))
        addSubview(slider)
        slider.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.right.equalTo(-40)
            make.height.equalTo(10)
            make.bottom.equalTo(-40)
        }
        //timer
        _timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerHandler(timer:)), userInfo: nil, repeats: true)
    }
    
    func timerHandler(timer:Timer) {
        _timeCout += 1
        
        
        let currenttime = CGFloat((playerLayer.player?.currentTime().value)!)/CGFloat((playerLayer.player?.currentTime().timescale)!)
        
        if playerLayer.player?.currentItem != nil {
            let duration = CGFloat((playerLayer.player?.currentItem?.duration.value)!)/CGFloat((playerLayer.player?.currentItem?.duration.timescale)!)
            print( duration)
        }
        
        
        print(currenttime)
    }
    
}
