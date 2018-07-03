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
    
    private var controlView = UIView()
    
    private var _layer = AVPlayerLayer()
    private var _timer = Timer()
    private var _timeCout:Int = 0
    
    private var slider = UISlider()
    private var sliderEdit = false
    private var timeLabel = UILabel()
    
    var playerLayer:AVPlayerLayer{
        get{
            return _layer
        }
        set(newVlaue) {
            _layer.removeFromSuperlayer()
            _layer = newVlaue
            layer.addSublayer(newVlaue)
            bringSubview(toFront: controlView)
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
        addSubview(controlView)
        controlView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(0)
        }
        //slider
        slider = UISlider.init(frame: CGRect.init(x: 0, y: 0, width: 10, height: 10))
        slider.addTarget(self, action: #selector(sliderUp), for: .touchUpInside)
        slider.addTarget(self, action: #selector(sliderCancel), for: .touchUpOutside)
        slider.addTarget(self, action: #selector(sliderDown), for: .touchDown)
        slider.addTarget(self, action: #selector(sliderChange), for: .valueChanged)
        controlView.addSubview(slider)
        slider.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.right.equalTo(-40)
            make.height.equalTo(10)
            make.bottom.equalTo(-40)
        }
        //label
        controlView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.width.equalTo(150)
            make.height.equalTo(20)
            make.bottom.equalTo(-20)
        }
        timeLabel.textColor = UIColor.white
        timeLabel.font = UIFont.boldSystemFont(ofSize: 12)
        
        //timer
        _timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerHandler(timer:)), userInfo: nil, repeats: true)
    }
    
    func timerHandler(timer:Timer) {
        _timeCout += 1
        
        
        var currenttime:CGFloat = 0
        var duration:CGFloat = 0
        
        if playerLayer.player?.currentItem != nil {
            duration = CGFloat((playerLayer.player?.currentItem?.duration.value)!)/CGFloat((playerLayer.player?.currentItem?.duration.timescale)!)
            slider.maximumValue = Float(duration)
            
            currenttime = CGFloat((playerLayer.player?.currentTime().value)!)/CGFloat((playerLayer.player?.currentTime().timescale)!)
            if !sliderEdit {
                slider.value = Float(currenttime)
            }
        }
        
        let ch = Int(currenttime)/60/60
        let cm = Int(currenttime)/60%60
        let cs = Int(currenttime)%60
        let dh = Int(duration)/60/60
        let dm = Int(duration)/60%60
        let ds = Int(duration)%60
        timeLabel.text = "\(String(format: "%02d", ch)):\(String(format: "%02d", cm)):\(String(format: "%02d", cs))-\(String(format: "%02d", dh)):\(String(format: "%02d", dm)):\(String(format: "%02d", ds))"
        //
    }
    
    func sliderUp() {
        let time = CMTime.init(value: CMTimeValue(slider.value*1000), timescale: 1000)
        playerLayer.player?.seek(to: time)
        sliderEdit = false
    }
    func sliderDown() {
        sliderEdit = true
    }
    func sliderCancel() {
        sliderEdit = false
    }
    func sliderChange() {
        //
    }
    
}
