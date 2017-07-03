//
//  AttackModel.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/7/3.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit

class AttackModel: FGOModel {
    func attactWithServents(from:ServentModel, to aim:ServentModel){
        let attact = from.attack + from.mysticCode.attack
    }
}
