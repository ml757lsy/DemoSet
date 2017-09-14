//
//  ProbabilityModel.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/7/5.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit

/// 概率计算model
class ProbabilityModel: FGOModel {

    /// 即死率计算
    ///
    /// - Parameters:
    ///   - from: from
    ///   - aim: 目标
    /// - Returns: 几率
    func dead(from:ServentModel, to aim:ServentModel) -> CGFloat {
        var deadP:CGFloat = 0
        for buff in from.buffers {
            if buff.buffType == .deadBuff {
                deadP = buff.value
            }
        }
        
        var addDead:CGFloat = 0
        for buff in from.buffers {
            if buff.buffType == .addDeadBuff {
                addDead += buff.value
            }
        }
        for buff in aim.buffers {
            if buff.buffType == .addDeadBuff {
                addDead -= buff.value
            }
        }
        
        let success = deadP * aim.dead * (1+addDead)
        
        return success
    }
}

/*
 即死是部分宝具特效中带有的，无条件直接使敌方HP变为0的强力效果。影响即死成功率的除了宝具自带的即死率之外，还包括被即死对象的死亡率。
 
 
 即死判定公式：
 
 即死成功率=即死概率×死亡率×（1-敌方即死耐性buff+敌方即死耐性debuff）
 
 公式注解
 
 
 （1）即死概率：即指宝具的即死率。极少数宝具即死率随宝具Lv.变化，绝大多数宝具即死率随宝具蓄力变化。
 
 （2）死亡率：即固有死亡率，是各怪物、从者的隐藏属性。己方从者的固有死亡率由自身的职阶、Status参数中的魔力Rank共同决定；敌方从者以外的大部分怪物的固有死亡率按稀有度分别为20%、50%、80%、100%不等；影从者大部分固有死亡率为10%；敌方从者与巨龙、恶魔一类Boss固有死亡率为0.2%甚至0%（即几乎不能被即死）。
 
 （3）即死耐性：抵抗即死的能力，不属于弱体耐性分类之中。
 
 
 
 值得注意的是，即死虽然能够无视回避与无敌状态，但只是使对象HP变为0而不是直接死亡，因此在被即死对象带有胆识（不屈）状态时，会使对象触发不屈继续战斗。
 

 */
