//
//  FGOModel.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/7/3.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit

/// 攻击修正
let attactCorrect:CGFloat = 0.23

struct carType {
    let Buster:CGFloat = 1.5
    let Arts:CGFloat   = 1.0
    let Quick:CGFloat  = 0.8
    let Extra:CGFloat  = 1.0
}

struct positionBuff {
    let First:CGFloat   = 1.0
    let Second:CGFloat  = 1.2
    let Third:CGFloat   = 1.4
    let Extra:CGFloat   = 1.0
}

struct firstBuff {
    let Buster:CGFloat  = 0.5
    let Other:CGFloat   = 0
}

struct classCorrect {
    let Saber:CGFloat       = 1.0
    let Archer:CGFloat      = 0.95
    let Lancer:CGFloat      = 1.05
    let Rider:CGFloat       = 1.0
    let Caster:CGFloat      = 0.9
    let Assassin:CGFloat    = 0.9
    let Berserker:CGFloat   = 1.1
    let Ruler:CGFloat       = 1.1
    let Shielder:CGFloat    = 1.0
    let Alterego:CGFloat    = 1.0
    let Avenger:CGFloat     = 1.1
    let Beast:CGFloat       = 1.0
}

struct classWeak {
    let Weak:CGFloat        = 0.5
    let Other:CGFloat       = 1.0
    let Berserker:CGFloat   = 1.5
    let Fatal:CGFloat       = 2.0
}

struct campWeak {
    let Weak:CGFloat    = 0.9
    let Other:CGFloat   = 1.0
    let Fatal:CGFloat   = 1.1
}

struct randomCorrect {
    let random:CGFloat = 0.9 + CGFloat(arc4random()%100)/100.0*0.2
}

struct critCorrect {
    let crit:CGFloat = 2.0
}

struct extraBuff {
    let busterChain:CGFloat = 3.5
    let other:CGFloat = 2.0
}

struct busterChain {
    let allBuster = 0.2
    let other = 0.0
}

class FGOModel: NSObject {
    
}
/*
 ATK×攻击补正×[卡牌伤害倍率×位置加成×(1+卡牌BUFF)+首位加成]×职阶补正×职阶相性补正×阵营相性补正×乱数补正×(1+攻击力BUFF—敌方防御力BUFF)×(1+特攻威力BUFF—敌方特防威力BUFF+暴击威力BUFF)×暴击补正×EX攻击奖励
 +(固定伤害BUFF—敌方固定伤害BUFF)
 + ATK×Buster Chain加成
 
  
 公式各项注解
 ①ATK：
 从者面板ATK与该从者所装备的礼装ATK之和，即从者实际ATK。
 ②攻击补正：
 常数[0.23]。
 ③卡牌伤害倍率：
 根据卡色分别为Buster卡[1.5]、Arts卡[1.0]、Quick卡[0.8]、EX攻击[1.0]。
 ④位置加成：
 根据指令卡位置分别为第一位[1.0]、第二位[1.2]、第三位[1.4]和第四位（即EX攻击）[1.0]。
 ⑤卡牌BUFF：
 此项是“卡牌性能BUFF－卡牌性能DEBUFF”的简写。影响此项的因素有从者保有技能"魔力放出"、怪物技能"蹂躏准备"、从者职阶技能"骑乘"、相关概念礼装、相关宝具特效等等。
 ⑥首位加成：
 分为首卡为红卡[0.5]、首卡非红卡[0]两种情况。
 ⑦职阶补正：
 不同职阶固有的攻击系数，三骑士Saber[1.00]、Archer[0.95]、Lancer[1.05]，四骑Rider[1.0]、Caster[0.9]、Assassin[0.9]、Berserker[1.1]，其他职阶Ruler[1.1]、Shielder[1.0]、Alter-ego[1.0]、Avenger[1.1]、Beast[1.0]。
 ⑧职阶相性补正：
 根据职阶克制关系，分为有克制[2.0]（攻击侧为Berserker时[1.5]）、被克制[0.5]和无克制[1.0]三种情况。
 ⑨阵营相性补正：
 有克制[1.1]、被克制[0.9]和无克制[1.0]三种情况。
 ⑩乱数补正：
 由系统在特定范围内随机生成[0.9～1.1]的随机数补正。
 ⑪攻击力BUFF：
 此项是“攻击力BUFF－攻击力DEBUFF”的简写。影响此项的因素有从者保有技能"怪力"、从者保有技能"破坏工作"、Master技能"瞬间强化"、相关概念礼装、相关宝具特效等等。
 ⑫敌方防御力BUFF：
 此项是“敌方防御力BUFF－防御力DEBUFF”的简写。影响此项的因素有从者保有技能"变化"、从者保有技能"拷问技术"、怪物技能"硬化"、相关宝具特效等等。
 ⑬特攻威力BUFF：
 敌人在Buff特攻范围内时计算此项，是针对特定对象的威力UP状态。例如从者保有技能"处刑人"、"银河流星剑"、相关概念礼装等等。某些活动期内，活动礼装的幅度极高的“攻击力UP”效果实质上也按特攻威力BUFF参与计算。
 另外，多个特攻叠加的情况，增幅为直接加算，这种情况只会发生在存在多个特攻Buff同时被触发时。同一个Buff，即使是有多个范围的特攻Buff，被触发一个以上特攻条件时仍然只计算一次增幅。
 ⑭敌方特防威力BUFF：
 我方在敌方Buff特防范围内时计算此项，是针对特定对象的防御力UP状态。如从者保有技能"屠龙者"。
 ⑮暴击补正：
 暴击时计算此项。为定值[2.0]。
 ⑯暴击威力BUFF：
 暴击时计算此项。这里是“暴击威力BUFF－暴击威力DEBUFF”的简写。影响此项的因素有从者保有技能"心眼(伪)"、从者保有技能"鉴识眼"、怪物技能"畏怖"、从者职阶技能"单独行动"、相关概念礼装等等。
 ⑰EX攻击奖励：
 指令卡为EX攻击时计算此项。有前三张指令卡同色（Chain）[3.5]和不同色[2.0]两种情况。
 ⑱固定伤害BUFF：
 增加固定伤害的BUFF。如从者保有技能"军师的指挥"、从者职阶技能"神性"、相关概念礼装等等。
 ⑲敌方固定伤害BUFF：
 敌方减免固定伤害的BUFF。如从者保有技能"军师的忠言"等。
 ⑳Buster Chain加成：
 当指令卡为EX攻击时，不计算此项。有前三张指令卡都为红卡[0.2]和不都为红卡[0]两种情况。
 二、宝具伤害计算公式
 ATK×攻击补正×[宝具倍率×卡牌伤害倍率×(1+卡牌BUFF)]×职阶补正×职阶相性补正×阵营相性补正×乱数补正×(1+攻击力BUFF—敌方防御力BUFF)×(1+特攻威力BUFF—敌方特防威力BUFF+宝具威力BUFF)×宝具特攻
 +(固定伤害BUFF—敌方固定伤害BUFF)
 
  atk*0.23*（4*1.5*（1+0.6））*0.95*2.0*1.1*1*（1+0.21+0.2）*（1+0）*1.5
 公式各项注解
 与普通指令卡相比，由于宝自身特性所以公式中省略了暴击补正和EX攻击奖励，多计算了宝具倍率和宝具特攻并把暴击威力BUFF等位替换为了宝具威力BUFF。另外首位加成、位置加成和Buster Chain加成这三项均未被列入公式中，因此宝具伤害与卡位、首位是否为Buster卡和是否组成Buster Chain等因素无关，日常操作时这一点尤其需要注意。
 
 （省略指令卡公式中注解过的项目）
 
 ①宝具倍率：
 宝具特有的伤害倍率。
 ②宝具威力BUFF：
 这里是“宝具威力BUFF-宝具威力DEBUFF”的简写。影响此项的因素有从者保有技能"军略"、从者保有技能"过载"、怪物技能"畏敬"、相关概念礼装等等。
 ③宝具特攻：
 “宝具特攻”与“特攻”的区别在于前者只加成宝具本身，作为宝具特效存在；后者是状态附加，持续时间内任何攻击都受加成。
 
 隐性阵营，也称天地人星兽阵营。阵营是从者和怪物的隐藏属性，有些阵营间会有部分的克制关系，这个隐藏属性也是影响伤害的因素之一。
 
  
 
 隐性阵营一共有五个，分别为「天」，「地」，「人」，「星」，「兽」。
 
 「天」一般为拥有神之血统的人类和怪物。
 
 「地」一般是传说中的英雄。
 
 「人」是大多是为人类做出贡献的历史英雄们。
 
 「星」阵营与「天」，「地」，「人」不同，「星」代表着人类的希望，是人类战胜困难的象征。
 
 「兽」特性与「星」互相克制，是人类的天敌，毁灭人类的象征。
 
  
 
 天地人星兽阵营克制关系如下——
 
 
 
 
 攻击／防御
 
 天
 地
 人
 星
 兽
 
 天
 
 1.0
 1.1
 0.9
 1.0
 1.0
 
 地
 
 0.9
 1.0
 1.1
 1.0
 1.0
 
 人
 
 1.1
 0.9
 1.0
 1.0
 1.0
 
 星
 
 1.0
 1.0
 1.0
 1.0
 1.1
 
 兽
 
 1.0
 1.0
 1.0
 1.1
 0.0
 
 
  

 */

