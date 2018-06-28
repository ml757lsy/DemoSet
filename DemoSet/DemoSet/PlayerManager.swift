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
    
    static let manager = PlayerManager()
    
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
    
}

/// 视图 比layer可以更好的自适应
class PlayerView: UIView {
    
    private var _layer = AVPlayerLayer()
    
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = layer.bounds
    }
    
}
