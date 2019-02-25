//
//  EmitterViewController.swift
//  DemoSet
//
//  Created by 李世远 on 2019/1/15.
//  Copyright © 2019 Far. All rights reserved.
//

import UIKit

class EmitterViewController: BaseViewController {
    
    var fireworksLayer:CAEmitterLayer = CAEmitterLayer.init()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fireWorks()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func fireWorks() {
        fireworksLayer = CAEmitterLayer.init()
        
        fireworksLayer.emitterPosition = CGPoint.init(x:self.view.layer.bounds.size.width * 0.5, y:self.view.layer.bounds.size.height); // 在底部
        fireworksLayer.emitterSize = CGSize.init(width:self.view.layer.bounds.size.width * 0.1, height:0);  // 宽度为一半
        fireworksLayer.emitterMode = CAEmitterLayerEmitterMode.outline;
        fireworksLayer.emitterShape = CAEmitterLayerEmitterShape.line;
        fireworksLayer.renderMode = CAEmitterLayerRenderMode.additive;
        fireworksLayer.birthRate = 1.0;
        
        //
        let shootCell = CAEmitterCell.init()
        shootCell.name = "shootCell"
        shootCell.birthRate = 1.0;
        shootCell.lifetime = 1.02;  // 上一个销毁了下一个再发出来
        
        shootCell.velocity = 600.0;
        shootCell.velocityRange = 100.0;
        shootCell.yAcceleration = 75.0;  // 模拟重力影响
        
        shootCell.emissionRange = CGFloat.pi * 0.25; //
        
        shootCell.scale = 0.2;
        shootCell.color = UIColor.red.cgColor;
        shootCell.greenRange = 1.0;
        shootCell.redRange = 1.0;
        shootCell.blueRange = 1.0;
        shootCell.contents = UIImage.init(named: "star")?.cgImage;//没有contents不会展示
        
        shootCell.spinRange = CGFloat.pi;  // 自转360度
        
        // 爆炸
        let explodeCell = CAEmitterCell.init();
        explodeCell.name = "explodeCell";
        
        explodeCell.birthRate = 1.0;
        explodeCell.lifetime = 0.3;
        explodeCell.velocity = 0.0;
        explodeCell.scale = 1;
        explodeCell.redSpeed = -1.5;  //爆炸的时候变化颜色
        explodeCell.blueRange = 1.5; //爆炸的时候变化颜色
        explodeCell.greenRange = 1.0; //爆炸的时候变化颜色
        
        // 火花
        let sparkCell = CAEmitterCell.init();
        sparkCell.name = "sparkCell"
        
        sparkCell.birthRate = 400.0;
        sparkCell.lifetime = 3.0;
        sparkCell.velocity = 125.0;
        sparkCell.yAcceleration = 75.0;  // 模拟重力影响
        sparkCell.emissionRange = CGFloat.pi * 2;  // 360度
        
        sparkCell.scale = 1.20;
        sparkCell.contents = UIImage.init(named: "star")?.cgImage
        sparkCell.redSpeed = 0.4;
        sparkCell.greenSpeed = -0.1;
        sparkCell.blueSpeed = -0.1;
        sparkCell.alphaSpeed = -0.25;
        
        sparkCell.spin = CGFloat.pi * 2; // 自转
        
        //添加动画
        fireworksLayer.emitterCells = [shootCell]
        shootCell.emitterCells = [explodeCell];
        explodeCell.emitterCells = [sparkCell];
        view.layer.addSublayer(fireworksLayer);
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
