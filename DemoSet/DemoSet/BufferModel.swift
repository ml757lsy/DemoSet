//
//  BufferModel.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/7/3.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit

enum BuffType {
    
    /// 卡牌buff 类似骑乘，魔放等buster性能提升
    case busterCardBuff
    case quickCardBuff
    case artsCardBuff
    
    /// 攻击力buff 类似领导力 怪力等攻击力变化
    case attackBuff
    
    /// 防御力buff 类似拷问 变化 硬化等防御力变化
    case defenceBuff
    
    /// 特攻buff 类似活动礼装加攻击 提升威力等
    case specialAttackBuff
    
    /// 特防buff 类似屠龙者 等伤害变化
    case specialDefenceBuff
    
    /// 暴击提升buff
    case critBuff
    
    /// 星星发生率buff
    case circleBuff
    
    /// 集星buff
    case starBuff
    
    /// 宝具威力buff 类似 军略等提升威力的buff
    case noblePhantasmBuff
    
    /// 宝具特攻buff 类似 女性特攻 从者特攻等宝具专属buff
    case noblePhantasmSpecialBuff
    
    /// 固定攻击buff 类似 军师的指挥 等增加固定伤害的buff
    case addAttackBuff
    
    /// 伤害减少buff 类似 军师的忠言 等减少固定伤害的buff
    case addDefenceBuff
    
    /// 无视防御buff
    case ignoreDefenceBuff
    
    /// 即死buff
    case deadBuff
    
    /// 即死增益或者抵抗buff
    case addDeadBuff
    
    /// 弱体抵抗buff
    case weakAgainstBuff
}

enum BuffClass {
    case passive    // 被动
    case debuff     // 减益
    case buff       // 增益
}

class BufferModel: FGOModel {
    var buffType:BuffType = .busterCardBuff
    var value:CGFloat = 0
    var aim:[CharacteristicType] = []//buff针对目标 针对特攻等类型使用
    
    
    /// 是否针对目标特性
    ///
    /// - Parameter characteristics: 特性
    /// - Returns: 是否针对
    func aim(with characteristics:[CharacteristicType]) -> Bool{
        var against = false
        
        for char in aim {
            for c in characteristics {
                if char == c {
                    against = true
                }
            }
        }
        
        return against
    }
}
