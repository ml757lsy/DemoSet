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
        let attack = from.attack + from.mysticCode.attack
        
    }
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
 
 
 
 
 攻击／防御    天     地       人       星        兽
 
 天          1.0     0.9     1.1     1.0     1.0
 地          1.1     1.0     0.9     1.0     1.0
 人          0.9     1.1     1.0     1.0     1.0
 星          1.0     1.0     1.0     1.0     1.1
 兽          1.0     1.0     1.0     1.1     1.0
 
-------
 
 
 NP获取是宝具输出型队伍战术的重要组成部分，卡牌的NP获取符合NP获取公式。NP的获取分为己方攻击的主动NP获取与受到敌方攻击的被动NP获取。
 
 
 
 1、主动NP获得量公式
 
 每Hit主动NP获得量×攻击Hit数×［卡牌NP倍率×位置加成×（1+卡牌Buff）＋首位加成］×（1+NP Buff）×暴击补正×Overkill补正×敌补正
 
 
 
 2、被动NP获得量公式
 
 每Hit被动NP获得量×敌方攻击Hit数×（1＋NP Buff）×Overkill补正 ×敌补正
 
 
 
 公式各项注解
 
 
 主动NP获得量公式为指令卡、宝具通用公式，但宝具不受暴击补正、卡位补正和首卡奖励加成。Arts Chain奖励是组成Chain的从者每人增加20NP，不在公式中，因此也不受任何加成，其他直接获得NP的技能或概念礼装效果同理。
 
 （1）每Hit主动NP获得量（N/A）:从者的隐藏属性，主动攻击时的基础NP获得量。大体由各个从者自身的职阶、配卡蓝卡数量、蓝卡Hit数、Status参数中的魔力Rank、宝具基础NP获得量等属性共同决定。
 
 （2）每Hit被动NP获得量（N/D）：从者的隐藏属性，被攻击时的基础NP获得量。由各个从者自身的职阶决定。
 
 （3）攻击Hit数：指令卡或宝具卡牌的攻击段数。
 
 （4）敌方攻击Hit数：敌人行动（实质也为指令卡）的攻击段数。
 
 （5）卡牌NP倍率：根据卡色分别为Buster卡[0]、Arts卡[3.0]、Quick卡[1.0]、EX攻击[1.0]。
 
 （6）位置加成：根据指令卡位置分别为第一位[1.0]、第二位[1.5]、第三位[2.0]和第四位（即EX攻击）[1.0]。
 
 （7）卡牌Buff：此项是“卡牌性能Buff－卡牌性能DeBuff”的简写。影响此项的因素有从者保有技能【狐嫁女】、怪物技能【蹂躏准备】、从者职阶技能【阵地作成】、相关概念礼装、相关宝具特效等等。
 
 （8）首位加成：首卡为Arts卡[1.0]，首卡非Arts卡[0]。此外因为宝具实质上仍是指令卡，所以Arts卡宝具也提供首位加成，只是宝具自身NP获得量不受Arts卡首位加成。
 
 （9）NP Buff：加成NP获取量的Buff。例如从者保有技能【黄金律】、【天狗的兵法】、相关概念礼装等等。
 
 （10）暴击补正：暴击时计算此项。为定值[2.0]。
 
 （11）Overkill补正：Overkill时计算此项。只要指令卡中有至少1Hit在敌方HP为0的情况下击出，便达成Overkill，战斗界面中会显示Overkill字样。为定值[1.5]。
 
 （12）敌补正：根据敌人的不同而变化，即使是相同敌人在不同副本中的敌补正也可能不同，目前发现的NP敌补正数值最大为1.32，最低为0.8。
  ------
 星星发生是暴击输出型队伍战术的重要组成部分，卡牌的星星发生符合星星发生公式。
 
 
 
 1、指令卡攻击时星星发生率公式
 
 ［星星发生率＋卡牌补正×（1＋卡牌Buff）＋首位加成＋星星发生率Buff＋暴击补正－敌方星星发生Buff－敌补正］×Overkill乘算补正＋Overkill加算补正
 
 
 
 2、宝具攻击时星星发生率公式
 
 ［星星发生率＋卡牌星星发生率×（1＋卡牌Buff）＋星星发生率Buff－敌方星星发生Buff－敌补正］×Overkill乘算补正＋Overkill加算补正
 
 
 
 公式各项注解
 
 
 攻击计算结果为攻击时每Hit的星星发生率。星星发生率超过100%情况下，每100%出星1个，剩下的零头按概率出1星。例如某次Hit星星发生率230%，则必定掉落2星，另有30%概率掉落第3颗星星。星星发生率上限为300%。宝具星星发生率不受首卡奖励和卡位补正加成。
 
 （1）星星发生率：从者的隐藏属性，攻击时每Hit掉落星星的基础概率。由各个从者自身的职阶、Status参数中的敏捷Rank共同决定。
 
 （2）卡牌星星发生率：即卡牌基础星星发生率，宝具打星时计算此项。根据卡色分别为Buster卡[10%]、Arts卡[0]和Quick卡[80%]。
 
 （3）卡牌补正：卡牌星星发生率与卡位补正的结合，指令卡打星时计算此项。根据卡色和卡位分别为第一位Buster卡[10%]、第二位Buster卡[15%]、第三位Buster卡[20%]、任意位Arts卡[0]、第一位Quick卡[80%]、第二位Quick卡[130%]、第三位Quick卡[180%]和第四位EX攻击[100%]。
 
 （4）卡牌Buff：此项是“卡牌性能Buff－卡牌性能DeBuff”的简写。影响此项的因素有从者保有技能【缩地】、怪物技能【先制准备】、从者职阶技能【骑乘】、相关概念礼装、相关宝具特效等等。
 
 （5）首位加成：首卡为Quick卡[20%]，首卡非Quick卡[0]。此外因为宝具实质上仍是指令卡，所以Quick卡宝具也可提供首位加成，只是宝具自身星星发生率不受首位加成。
 
 （6）星星发生率Buff：此项是“星星发生率Buff－星星发生率DeBuff”的简写。影响此项的因素有从者保有技能【千里眼】、敌方从者保有技能【情报抹消】、从者职阶技能【气息遮断】、相关概念礼装、相关宝具特效等等。
 
 （7）暴击补正：暴击时计算此项。为定值[20%]
 
 （8）敌方星星发生率Buff：由于敌方的星星发生率buff技能会转变成暴击发生率buff技能，因此此项基本不进行计算。
 
 （9）Overkill乘算补正：只要指令卡中有至少1Hit在敌方HP为0的情况下击出，便达成Overkill，战斗界面中会显示Overkill字样。此项为旧版星星发生公式的一部分，公式改版后因为某些原因并没有被从公式中删去，而是变成了对计算无影响的常数[1]
 
 （10）Overkill加算补正：Overkill时计算此项。为定值[30%]
 
 （11）敌补正：根据敌人的不同而变化，即使是相同敌人在不同副本中的敌补正也可能不同，目前发现的星星发生敌补正数值最大为20%，最低为-10%。
 ------
 1、暴击权重
 
 “暴击权重”是星星分配给指令卡的依据，也称星星集中度。作为从者的隐藏属性，各个从者的固有暴击权重（时常简称“暴击权重”）由自身的职阶、Status参数中的幸运Rank共同决定。 战斗中各个从者的每张指令卡都会带上从者自身的固有暴击权重，且每回合抽到的五张手牌中会随机被系统分别赋予50、20、20、0、0的额外暴击权重，在此基础上实际权重还可能受技能或礼装的星星集中状态影响。
 
 因此实战中从者各张指令卡的实际暴击权重计算公式为：
 固有暴击权重×（1＋星星集中Buff－星星集中DeBuff）＋额外暴击权重
 
 2、星星分配机制说明
 
 每回合可供分配的星星，由三部分组成，分别是上回合攻击中发生的星星、上回合宝具特效获得的星星、本回合技能获得的星星。在玩家点开Attack键拿出五张指令卡的瞬间，这些星星全部被分配给指令卡。星星被分给某张指令卡的概率，就是该指令卡当回合实际暴击权重在五张指令卡暴击权重总和中所占的百分比。
 
 
 
 以抽奖转盘为例来说明：
 
 
 用转盘抽奖，把转盘分为几个大小不等的区域，转盘不动，转动指针，停止转动时，由指针停留在转盘的哪一个区域来判断是否中奖、中几等奖。暴击星星的分配是一样的道理。每张指令卡按暴击权重占总权重的百分比来把转盘划分成一块块区域，而转盘的指针就是将要被分配的那一颗星星，星星转动后停留在哪张卡的区域内，这颗星星就被分配给哪张卡。因为每张指令卡最多能获得10星星，所以当某张指令卡拿足10星后就会退出转盘，由剩下的指令卡按各自暴击权重重新组成一个转盘继续分配星星，直到本回合所有星星都被逐一分配完毕，或者五张指令卡都拿足10星星为止。
 如果某张指令卡实际权重为0，则始终不参与星星分配。也就是说即使该回合有超过50星星，该指令卡可分得的星数也是0。
 
 
 
 以模拟实战来说明
 
 
 假设：场上有三名从者A、B、C，从者A的固有暴击权重为【200】，从者B的固有暴击权重为【100】，从者C的固有暴击权重为【50】。本回合有1颗暴击星星可供分配。
 
 
 
 步骤Ⅰ：本回合抽到的5张指令卡分别为
 
 从者A的指令卡A1【固有权重200】
 
 从者B的指令卡B1【固有权重100】
 
 从者C的指令卡C1【固有权重50】
 
 从者A的指令卡A2【固有权重200】
 
 从者C的指令卡C2【固有权重50】
 
 （为了阅读方便，之后直接用编号来表示上面的指令卡）
 
 
 
 步骤Ⅱ：计算5张卡的实际暴击权重，并假设A1、B1、C1的额外暴击权重分别为50、20、20。无星星集中状态。
 
 A1【固有200+额外50=250】
 
 B1【固有100+额外20=120】
 
 C1【固有50+额外20=70】
 
 A2【固有200+额外0=200】
 
 C2【固有50+额外0=50】
 
 
 
 步骤Ⅲ：计算这五张卡暴击权重之和，并算出每张卡的权重占总和的百分比。
 
 A1【250】36.23％
 
 B1【120】17.39％
 
 C1【70】10.14％
 
 A2【200】28.99％
 
 C2【50】7.25％
 
 
 
 得出结论：本回合这1颗星星被分给各张指令卡的概率如上。各从者获得星星的概率分别为A65.22％、B17.39％、C17.39％。
 
 
 
 因为以上假设中没有考虑星星集中状态，所以接下来可以继续计算存在星星集中状态的情况。
 
 
 
 步骤Ⅳ：其他条件不变，为从者A单独赋予600%的星星集中Buff。
 
 A1【200×（1＋600%）＋50=1450】46.93％
 
 B1【120】3.88％
 
 C1【70】2.27％
 
 A2【200×（1＋600%）=1400】45.31％
 
 C2【50】1.61％
 
 此时从者A两张指令卡平均星星获得概率由Ⅲ中的32.61%提升为46.12%。
 
 
 
 步骤Ⅴ：其他条件不变，为从者B单独赋予600%的星星集中Buff。
 
 A1【250】19.28％
 
 B1【100×（1+600%）＋20=720】55.81％
 
 C1【70】5.43％
 
 A2【200】15.50％
 
 C2【50】3.88％
 
 此时从者B一张指令卡星星获得概率由Ⅲ中的17.39%提升为55.81%。
 
 
 
 步骤Ⅵ：其他条件不变，为从者C单独赋予600%的星星集中Buff。
 
 A1【250】19.38％
 
 B1【120】9.30％
 
 C1【50×（1＋600％）＋20=370】28.68％
 
 A2【200】15.51％
 
 C2【50×（1＋600％）=350】27.13％
 
 此时从者C两张指令卡平均星星获得概率由Ⅲ中的8.70%提升为29.91%。
 
 
 
 步骤Ⅶ：其他条件不变，为从者C单独赋予100%的星星集中DeBuff。
 
 A1【250】42.37％
 
 B1【120】20.34％
 
 C1【50×（1－100％）＋20=20】3.39％
 
 A2【200】33.90％
 
 C2【50×（1－100％）=0】0％
 
 此时从者C两张指令卡基础权重被减为0，则只有分配到了随机权重的指令卡能集星。同时从者A、B的指令卡星星获得概率有所提升。
 
 
 
 得出结论：星星集中状态的收益受队伍成员权重差距和5张手牌中集星卡牌数量影响较大，实战时，特别是给从者装备赋予集星状态的礼装时需要慎重计算收益。
-----------
 弱体指异常状态，也就是Debuff。战斗中赋予弱体的手段是各类技能和宝具特效。
 
 
 
 1、弱体分类
 
 普通弱体
 
 
 毒、诅咒：一定时间内每回合受到固定伤害。
 
 灼烧：一定时间内每回合受到固定伤害。
 
 石化、行动不能、眩晕、拘束：一回合内无法行动。
 
 技能封印：一定回合内无法发动技能。
 
 宝具封印：一定回合内无法发动宝具。
 
 其他各类Down（除开已划入攻击弱体与防御弱体中的）：星星发生率Down、卡性能Down、弱体耐性Down等等。
 
 攻击弱体
 
 
 各类攻击力Down、宝具威力Down、暴击威力Down、攻击伤害固定减少、暴击发生率Down。
 
 防御弱体
 
 
 各类防御力Down、被攻击伤害固定增加。
 
 精神弱体、精神异常
 
 
 魅惑：一回合内无法行动。
 
 
 
 2、弱体成功率公式
 
 实际弱体成功率=弱体成功率+成功率Buff-敌方弱体耐性Buff
 
 公式注解
 
 
 （1）弱体成功率：技能或宝具赋予敌方弱体的成功率，未直接标出成功率的弱体手段一般默认成功率100%。
 
 （2）成功率Buff：增加弱体成功率的Buff。如从者保有技能【神之恩宠】、从者职阶技能【道具作成】、相关概念礼装等等。
 
 （3）敌方弱体耐性Buff：此项是“敌方弱体耐性Buff－敌方弱体耐性DeBuff”的简写。影响此项的因素有从者保有技能【信仰的加护】、从者保有技能【贫者的见识】、从者职阶技能【对魔力】、相关概念礼装、相关宝具特效等等。
 
 
 
 注：蓄力或NP消灭、HP减少、强化解除、即死不属于弱体，因此其成功率的计算不受弱体成功率与弱体耐性影响。
-----
 即死是部分宝具特效中带有的，无条件直接使敌方HP变为0的强力效果。影响即死成功率的除了宝具自带的即死率之外，还包括被即死对象的死亡率。
 
 
 
 即死判定公式：
 
 即死成功率=即死概率×死亡率×（1-敌方即死耐性buff+敌方即死耐性debuff）
 
 公式注解
 
 
 （1）即死概率：即指宝具的即死率。极少数宝具即死率随宝具Lv.变化，绝大多数宝具即死率随宝具蓄力变化。
 
 （2）死亡率：即固有死亡率，是各怪物、从者的隐藏属性。己方从者的固有死亡率由自身的职阶、Status参数中的魔力Rank共同决定；敌方从者以外的大部分怪物的固有死亡率按稀有度分别为20%、50%、80%、100%不等；影从者大部分固有死亡率为10%；敌方从者与巨龙、恶魔一类Boss固有死亡率为0.2%甚至0%（即几乎不能被即死）。
 
 （3）即死耐性：抵抗即死的能力，不属于弱体耐性分类之中。
 
 
 
 值得注意的是，即死虽然能够无视回避与无敌状态，但只是使对象HP变为0而不是直接死亡，因此在被即死对象带有胆识（不屈）状态时，会使对象触发不屈继续战斗。
 
 
 ------
 2、职阶技能
 
 从者持有的在战斗中自动发动的技能。如Rider的骑乘，Berserker的狂化等。职阶技能在FGO以被动常驻的形式给从者提升某些能力。
 职阶技能	效果                  E-	E	D	C	C+	B	A	A+	A++	EX
 骑乘	自身的绿卡性能提升       -	2	4	6	-	8	10	11	12	12
 阵地作成	自身的蓝卡性能提升       -	2	4	6	7	8	10	-	-	12
 狂化	自身的红卡性能提升       -	2	4	6	-	8	10	11	-	12
 单独行动	自身的暴击伤害提升       -	2	4	6	-	8	10	11	-	12
 气息遮断	自身的星星发生率提升      -	2	4	6	-	8	10	11	-	12
 道具作成	自身的弱体成功率提升      -	2	4	6	-	8	10	-	-	12
 神性	自身的固定伤害提升       95	100	130	150	160	180	200	-	-	250
 对魔力	自身的弱体耐性提升       -	10	13	15	16	18	20	-	-	25
 女神的神核	自身的固定伤害提升   -	-	-	-	-	-	-	-	-	300
 自身的弱体耐性提升              -	-	-	-	-	-	-	-	-	30
 
 ----
 每个从者均有4次灵基再临的机会，每次灵基再临将提升从者10级的等级上限。不同稀有度的从者的等级上限各不相同。
 不同从者灵基等级	第1阶段	第2阶段	第3阶段	第4阶段
 1星从者           20      30      40      50
 2星从者           25      35      45      55
 3星从者（R）        30      40      50      60
 4星从者（SR）       40      50      60      70
 5星从者（SSR）      50      60      70      80
 
 ---
 圣杯转临
 
 通过消耗圣杯和QP，使已达到灵基再临与等级上限的从者继续开放等级上限。圣杯转临的过程不可逆。70级以下的第一次转临会达到70级上限，70级~90级之间每一次转临开放5级等级上限，90级意思每一次转临开放2级等级上限，最高达到100级。
 */
