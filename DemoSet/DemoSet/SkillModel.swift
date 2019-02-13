//
//  SkillModel.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/7/6.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit

enum BaseLevel:Int {
    case N      = -1 //无等级
    
    case Er     = 0//E-
    case E      = 1
    case Ep     = 2//E+
    case Epp    = 3
    case Eppp   = 4
    
    case Dr     = 5
    case D      = 6
    case Dp     = 7
    case Dpp    = 8
    case Dppp   = 9
    
    case Cr     = 10
    case C      = 11
    case Cp     = 12
    case Cpp    = 13
    case Cppp   = 14
    
    case Br     = 15
    case B      = 16
    case Bp     = 17
    case Bpp    = 18
    case Bppp   = 19
    
    case Ar     = 20
    case A      = 21
    case Ap     = 22
    case App    = 23
    case Appp   = 24//A+++ 好像只有李书文
    
    case Exr    = 25
    case EX     = 26
}

enum SkillType {
    case passive
    case initiative
}

/// 技能模型
class SkillModel: FGOModel {

    var baseLevel:BaseLevel = .N//固有等级
    
    var skillLevel:Int = 1//技能等级
    var skillIcon:String = ""//图标
    var title:String = ""//名称
    
    var selfBuffers:[BufferModel] = []
    var enemyBuffers:[BufferModel] = []
    
    //MARK: -
    
    /// 根据设定和等级获取数值
    ///
    /// - Parameters:
    ///   - values: 设定
    ///   - level: 等级
    ///   - change: 调整
    /// - Returns: 数值
    class func value(with values:[CGFloat], at level:BaseLevel, and change:CGFloat) -> CGFloat{
        
        var value:CGFloat = values[level.rawValue%5]
        if level.rawValue%5 < 1 {
            value -= change
        }
        if level.rawValue%5 > 1 {
            value += change * CGFloat(level.rawValue%5-1)
        }
        
        return value
    }
    
    //MARK: -
    
    /// 骑乘
    ///
    /// - Parameter baseLevel: 固有等级
    class func ride(baseLevel:BaseLevel) -> SkillModel{
        
        let rideValues:[CGFloat] = [0.02, 0.04, 0.06, 0.08, 0.10, 0.12]
        let change:CGFloat = 0.01
        var value = rideValues[baseLevel.rawValue/5]
        
        if baseLevel.rawValue%5 < 1 {
            value -= change
        }
        if baseLevel.rawValue%5 > 1 {
            value += change
        }
        //buff
        let quickBuff = BufferModel()
        quickBuff.buffType = .quickCardBuff
        quickBuff.value = value
        
        //skill
        let rideSkill = SkillModel()
        rideSkill.baseLevel = baseLevel
        rideSkill.selfBuffers.append(quickBuff)
        
        return rideSkill
        
    }
    
    /// 神性
    ///
    /// - Parameter baseLevel: 固有等级
    class func divinity(baseLevel:BaseLevel) -> SkillModel{
        let divinityValues:[CGFloat] = [100,125,150,175,200,300]
        let change:CGFloat = 5
        let value = SkillModel.value(with: divinityValues, at: baseLevel, and: change)
        //
        let aattackbuff = BufferModel()
        aattackbuff.buffType = .addAttackBuff
        aattackbuff.value = value
        //
        let divinitySkill = SkillModel()
        divinitySkill.baseLevel = baseLevel
        divinitySkill.selfBuffers.append(aattackbuff)
        
        return divinitySkill
    }
    
    /// 对魔力
    ///
    /// - Parameter baseLevel: 固有等级
    /// - Returns: skill
    class func magicDefence(baseLevel:BaseLevel) -> SkillModel{
        let magicDefenceValues:[CGFloat] = [0.1, 0.125, 0.15, 0.175, 0.20, 0.25]
        let change:CGFloat = 0.005
        let value = SkillModel.value(with: magicDefenceValues, at: baseLevel, and: change)
        //buff
        let magicDBuff = BufferModel()
        magicDBuff.buffType = .weakAgainstBuff
        magicDBuff.value = value
        
        
        let magicD = SkillModel()
        magicD.baseLevel = baseLevel
        magicD.selfBuffers.append(magicDBuff)
        
        return magicD
    }
    
    /// 狂化
    ///
    /// - Parameter baseLevel: 固有等级
    /// - Returns: skill
    class func berserker(baseLevel:BaseLevel) -> SkillModel{
        let berserkerValues:[CGFloat] = [0.02, 0.04, 0.06, 0.08, 0.10, 0.12]
        let change:CGFloat = 0.01
        let value:CGFloat = SkillModel.value(with: berserkerValues, at: baseLevel, and: change)
        //buff
        let berbuff = BufferModel()
        berbuff.buffType = .busterCardBuff
        berbuff.value = value
        
        let berserker = SkillModel()
        berserker.baseLevel = baseLevel
        berserker.selfBuffers.append(berbuff)
        
        return berserker
    }
    
    /// 阵地作战
    ///
    /// - Parameter baseLevel: 固有等级
    /// - Returns: skill
    class func positionalwarfare(baseLevel:BaseLevel) -> SkillModel {
        let artisValues:[CGFloat] = [0.02, 0.04, 0.06, 0.08, 0.10, 0.12]
        let change:CGFloat = 0.01
        let value:CGFloat = SkillModel.value(with: artisValues, at: baseLevel, and: change)
        //buff
        let artsbuff = BufferModel()
        artsbuff.buffType = .artsCardBuff
        artsbuff.value = value
        
        let artis = SkillModel()
        artis.baseLevel = baseLevel
        artis.selfBuffers.append(artsbuff)
        
        return artis
    }
    
    /// 单独行动
    ///
    /// - Parameter baseLevel: 固有等级
    /// - Returns: skill
    class func single(baseLevel:BaseLevel) -> SkillModel {
        let singleValues:[CGFloat] = [0.02, 0.04, 0.06, 0.08, 0.10, 0.12]
        let change:CGFloat = 0.01
        let value:CGFloat = SkillModel.value(with: singleValues, at: baseLevel, and: change)
        //buff
        let singleBuff = BufferModel()
        singleBuff.buffType = .critBuff
        singleBuff.value = value
            
        let single = SkillModel()
        single.baseLevel = baseLevel
        single.selfBuffers.append(singleBuff)
        
        return single
    }
    
    /// 气息遮蔽
    ///
    /// - Parameter baseLevel: 固有等级
    /// - Returns: skill
    class func hiden(baseLevel:BaseLevel) -> SkillModel{
        let hidenValues:[CGFloat] = [0.02, 0.04, 0.06, 0.08, 0.10, 0.12]
        let change:CGFloat = 0.01
        let value:CGFloat = SkillModel.value(with: hidenValues, at: baseLevel, and: change)
        //buff
        let hidenBuff = BufferModel()
        hidenBuff.buffType = .circleBuff
        hidenBuff.value = value
        
        //
        let hiden = SkillModel()
        hiden.baseLevel = baseLevel
        hiden.selfBuffers.append(hidenBuff)
        
        return hiden
    }
    
    /// 道具做成
    ///
    /// - Parameter baseLevel: 固有等级
    /// - Returns: skill
    class func propmade(baseLevel:BaseLevel) -> SkillModel{
        let propValues:[CGFloat] = [0.02, 0.04, 0.06, 0.08, 0.10, 0.12]
        let change:CGFloat = 0.01
        let value:CGFloat = SkillModel.value(with: propValues, at: baseLevel, and: change)
        
        //buff
        let propBuff = BufferModel()
        propBuff.buffType = .weakAgainstBuff
        propBuff.value = value
        
        //
        
        let propmade = SkillModel()
        propmade.baseLevel = baseLevel
        propmade.selfBuffers.append(propBuff)
        
        return propmade
    }
    
    /// 臻至化境
    ///
    /// - Parameter baseLevel: 固有等级
    /// - Returns: skill
    class func consummate(baseLevel:BaseLevel) -> SkillModel {
        //value
        
        //buff
        //5% 魅惑100% 即死免疫
        
        //skill
        let consummate = SkillModel()
        
        return consummate
    }
    
    /// 女神的神核
    ///
    /// - Parameter baseLevel: 固有等级
    /// - Returns: skill
    class func goddessnucleus(baseLevel:BaseLevel) -> SkillModel {
        
        
        return SkillModel()
    }
    
    /// 反救世主
    ///
    /// - Parameter baseLevel: 固有等级
    /// - Returns: skill
    class func resavior(baseLevel:BaseLevel) -> SkillModel {
        
        return SkillModel()
    }
    
    
    /// 无限的魔力供给
    ///
    /// - Parameter baseLevel: 固有等级
    /// - Returns: skill
    class func infiniteMagicSupport(baseLevel:BaseLevel) -> SkillModel {
        
        //C np+3
        //B np+4
        return SkillModel()
    }
    
    /// 自我回复
    ///
    /// - Parameter baseLevel: 固有等级
    /// - Returns: skill
    class func selfRepair(baseLevel:BaseLevel) -> SkillModel {
        
        //D np+3
        //A+ np+4
        return SkillModel()
    }
    
    /// 混血
    ///
    /// - Parameter baseLevel: 固有等级
    /// - Returns: skill
    class func miscegenation(baseLevel:BaseLevel) -> SkillModel {
        
        //EX np+5
        //e-2 cd-3 ba-4 x-5 应该是同等级的技能
        return SkillModel()
    }
    
    
}
