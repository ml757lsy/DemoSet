//
//  ServentModel.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/7/3.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit

enum CardQuality:Int {
    case copper
    case silver
    case gold
}

enum ClassType:Int {
    case saber
    case archer
    case lancer
    case rider
    case caster
    case assassin
    case berserker
    case ruler
    case shielder
    case alterego
    case avenger
    case mooncancer
    case beast
    case foreigner
}

enum CampType:Int {
    case sky
    case earth
    case man
    case star
    case beast
}

enum CardType:Int {
    case buster
    case arts
    case quick
    case extra
}

enum PositionType:Int {
    case first
    case second
    case third
    case extra
}
enum CharacteristicType:Int{
    case servent//从者
    case man//人
    case sky//天
    case earth//地
    case star//星
    case starServent//特别星之从者
    case divinity//神性
    case king//王
    case saber//阿尔托莉雅
    case saberface//阿尔托莉雅脸
    case skyorearth//天/地从者
    case beast//野兽
    case rider//骑乘
    case drogen//龙
    case arthur//亚瑟
    case rome//罗马
    case loved//所爱之人
    case men//男
    case women//女
    case dead//死灵
}

enum SexType:Int{
    case man
    case woman
    case other
}

enum DDCamp:Int {
    case Lawful     = 10
    case Neutral    = 20
    case Chaotic    = 30
    
    case good       = 1
    case neutral    = 2
    case evil       = 3
}

enum GrowCurve:Int {
    case inverseSHeight
    case inverseS
    case line
    case positiveS
    case positiveSHeight
}



/// 从者模型
class ServentModel: FGOModel {

    var serventid:Int  = 0//id
    var avatar:String = ""// 头像
    var star:Int = 0//星数
    var quality:CardQuality = .copper
    var serventName:String = ""//姓名
    var serventLevel:Int = 1
    var attack:Int = 0
    var hp:Int = 0
    var classType:ClassType = .saber
    var campType:CampType = .sky
    var sex:SexType = .man
    
    /// 特性
    var characteristic:Set<CharacteristicType> = []
    
    var noplePhantasmType:CardType = .buster
    var noplePhantasmCharge:Int = 0
    var noplePhantasmRate:CGFloat = 1
    
    //特殊属性
    var busterHits:Int = 0
    var artsHits:Int = 0
    var quickHits:Int = 0
    var extraHits:Int = 0

    //DD九宫格阵营
    var DDCamp:Int = 0

    var critical:CGFloat = 0.122//收集星
    var dead:CGFloat = 0.32//即死率
    var crit:CGFloat = 88//暴击权重

    var npq:CGFloat = 0.0071
    var npb:CGFloat = 0.0071
    var npa:CGFloat = 0.0071
    var npe:CGFloat = 0.0071
    var npp:CGFloat = 0.0071//宝具np获取率
    var nph:CGFloat = 0.04//受伤np获取率

    //
    var exp:CGFloat = 0
    
    var expLevel:[CGFloat] = []
    
    //其他
    
    var mysticCode:MysticCodeModel = MysticCodeModel()
    
    var buffers:[BufferModel] = []
    
    
    private func attack(with level:Int) -> CGFloat{
        
        return 0
    }
    
    private func hp(with level:Int) -> CGFloat{
        return 0
    }
    /*
     Pt = (K*P0*e^rt)/(K+P0*(e^rt-1))
     k 终值
     p0 初始值
     r 曲度
     
     y=1/(a+b*exp(-x))
     
     y=K/(1+Exp(a-bx))
     */
    
}

