//
//  TiledImageView.swift
//  DemoSet
//
//  Created by 李世远 on 2019/1/7.
//  Copyright © 2019 Far. All rights reserved.
//

import UIKit

class TiledImageView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var image: UIImage = UIImage.init()
    
    override var layer: CALayer {
        return CATiledLayer.init()
    }
    
    class func initWith(frame:CGRect,image:UIImage) -> TiledImageView {
        let view = TiledImageView.init(frame: frame)
        
        view.image = image
        
        let layer = view.layer as! CATiledLayer;
//        layer.levelsOfDetailBias = 5;
        layer.tileSize = CGSize.init(width: 10, height: 10);
        
        return view;
    }
    
    override func draw(_ rect: CGRect) {
        
        var w = self.image.size.width
        var h = self.image.size.height
        var l:CGFloat = 0
        var t:CGFloat = 0
        var scal = w/rect.size.width
        if w/h < rect.size.width/rect.size.height {
            //过高
            scal = h/rect.size.height
            w = w/scal
            h = h/scal
            l = (rect.size.width-w)/2
        }else{
            //过宽
            w = w/scal
            h = h/scal
            t = (rect.size.height-h)/2
        }
        
        
        self.image.draw(in: CGRect.init(x: l, y: t, width: w, height: h))
    }
    

}
