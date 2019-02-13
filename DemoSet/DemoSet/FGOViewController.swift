//
//  FGOViewController.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/7/3.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit

class FGOViewController: BaseViewController {

    private let NPModel = NoblePhantasmModel.defaultModel
    
    override func viewDidLoad() {
        super.viewDidLoad()

        base()
        
        scure()
    }

    func base(){
        //
        let ji = ServentModel()
        ji.serventName = "Gilgamesh"
        ji.attack = 12280 + 990
        ji.hp = 13097 + 990
        ji.campType = .sky
        ji.classType = .archer
        ji.characteristic.insert(.divinity)
        ji.characteristic.insert(.man)
        ji.characteristic.insert(.king)
        ji.characteristic.insert(.servent)
        ji.characteristic.insert(.skyorearth)
        ji.noplePhantasmRate = 4
        ji.noplePhantasmType = .buster
        
        let leader:BufferModel = BufferModel()
        leader.buffType = .attackBuff
        leader.value = 0.21
        
        let npbuff:BufferModel = BufferModel()
        npbuff.buffType = .noblePhantasmBuff
        npbuff.value = 0.3
        
        let npsbuff:BufferModel = BufferModel()
        npsbuff.buffType = .noblePhantasmSpecialBuff
        npsbuff.value = 0.5
        
        let critbuff:BufferModel = BufferModel()
        critbuff.buffType = .critBuff
        critbuff.value = 0.11
        
        let aattackbuff:BufferModel = BufferModel()
        aattackbuff.buffType = .addAttackBuff
        aattackbuff.value = 175
        
        //
        let aim = ServentModel()
        aim.hp = 1000000
        aim.campType = .earth
        aim.classType = .berserker
        aim.characteristic.insert(.servent)
        
        NPModel.noplePhantasm(from: ji, to: aim)
        /*
         buff
         atk
         
         card
         
         
         
         
         
         */
    }
    
    
    func addServent() {
    }
    
    func saveServent() {
    }
    
    func scure() {
        /*
         Pt = (K*P0*e^rt)/(K+P0*(e^rt-1))
         y=K/(1+Exp(a-bx))
         y=K*Exp(a+bx)/(Exp(a+bx)+1)
         */
        
        let k:CGFloat = 103.2
        let po:CGFloat = 16.5
        let r:CGFloat = 0.07
        //y = 0.0463x3 - 5.7999x2 + 289.32x + 895.4
        let a:CGFloat = -10
        let b:CGFloat = -2*a/80

        for i in 1...80 {
            let x = CGFloat(i)
            let top = exp(a+b*x)
            let bottom = 1+exp(a+b*x)
            let t = k*top/bottom
            let point = CGPoint.init(x: CGFloat(i+100), y: 300-t)
            
            let v = UIView()
            v.frame = CGRect.init(x: 0, y: 0, width: 2, height: 2)
            v.backgroundColor = UIColor.red
            v.center = point
            view.addSubview(v)
            print("\(i)-\(t)")
        }
        
    }

}
