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
    }

    func base(){
        //
        let ji = ServentModel()
        ji.serventName = "Gilgamesh"
        ji.attack = 12280 + 990
        ji.hp = 13097 + 990
        ji.campType = .sky
        ji.classType = .archer
        ji.characteristic.append(.divinity)
        ji.characteristic.append(.man)
        ji.characteristic.append(.king)
        ji.characteristic.append(.servent)
        ji.characteristic.append(.skyorearth)
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
        aim.characteristic.append(.servent)
        
        NPModel.noplePhantasm(from: ji, to: aim)
    }
    
    
    func addServent() {
    }
    
    func saveServent() {
    }

}
