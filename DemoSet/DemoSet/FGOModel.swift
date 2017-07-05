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

struct cardCorrect {
    let Buster:CGFloat = 1.5
    let Arts:CGFloat   = 1.0
    let Quick:CGFloat  = 0.8
    let Extra:CGFloat  = 1.0
    
    func cardcorrect(with cardType:CardType) -> CGFloat{
        switch cardType {
        case .buster:
            return Buster
        case .arts:
            return Arts
        case .quick:
            return Quick
        case .extra:
            return Extra
        default:
            return Buster
        }
    }
}

struct positionBuff {
    let First:CGFloat   = 1.0
    let Second:CGFloat  = 1.2
    let Third:CGFloat   = 1.4
    let Extra:CGFloat   = 1.0
    
    func positionbuff(with position:PositionType) -> CGFloat{
        switch position {
        case .first:
            return First
        case .second:
            return Second
        case .third:
            return Third
        case .extra:
            return Extra
        default:
            return First
        }
    }
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
    
    func classcorrect(with serventClass:ClassType) -> CGFloat{
        switch serventClass {
        case .saber:
            return Saber
        case .archer:
            return Archer
        case .lancer:
            return Lancer
        case .rider:
            return Rider
        case .caster:
            return Caster
        case .assassin:
            return Assassin
        case .berserker:
            return Berserker
        case .ruler:
            return Ruler
        case .shielder:
            return Shielder
        case .alterego:
            return Alterego
        case .avenger:
            return Avenger
        case .beast:
            return Beast
        default:
            return Saber
        }
    }
}

struct classWeak {
    let Weak:CGFloat        = 0.5
    let Other:CGFloat       = 1.0
    let Berserker:CGFloat   = 1.5
    let Fatal:CGFloat       = 2.0
    
    func classweak(from fromClass:ClassType, to aimClass:ClassType) -> CGFloat{
        //特殊的
        //盾娘无所畏惧
        if fromClass == .shielder||aimClass == .shielder {
            return Other
        }
        
        //b阶傲视群雄
        if fromClass == .berserker {
            return Berserker
        }
        
        //大b哥舍我其谁
        if aimClass == .berserker {
            return Fatal
        }
        
        //其他
        //尺子哦呵呵
        if aimClass == .ruler {
            if fromClass == .avenger {
                return Fatal
            }else{
                return Weak
            }
        }
        //bb···
        if fromClass == .mooncancer {
            if aimClass == .avenger {
                return Fatal
            }else{
                return Other
            }
        }
        //复仇 怕bb 额
        if fromClass == .avenger {
            if aimClass == .mooncancer {
                return Weak
            }else{
                return Other
            }
        }
        
        //除了b谁都不克alterego 666
        if aimClass == .alterego {
            
            return Other
        }
        //还克下三阶 666
        if fromClass == .alterego {
            
            if aimClass == .caster||aimClass == .rider||aimClass == .assassin {
                // FIXME: - 克制系数是多少呢 2.0还是1.5
                return Fatal
            }else{
                return Other
            }
        }
        
        //上
        if fromClass == .saber {
            if aimClass == .lancer {
                return Fatal
            }else
                if aimClass == .archer {
                    return Weak
                }else{
                    return Other
            }
        }
        
        if fromClass == .archer {
            if aimClass == .saber {
                return Fatal
            }else
                if aimClass == .lancer {
                    return Weak
                }else{
                    return Other
            }
        }
        
        if fromClass == .lancer {
            if aimClass == .archer {
                return Fatal
            }else
                if aimClass == .saber {
                    return Weak
                }else{
                    return Other
            }
        }
        
        //下
        if fromClass == .rider {
            if aimClass == .caster {
                return Fatal
            }else
                if aimClass == .assassin {
                    return Weak
                }else{
                    return Other
            }
        }
        
        if fromClass == .caster {
            if aimClass == .assassin {
                return Fatal
            }else
                if aimClass == .rider {
                    return Weak
                }else{
                    return Other
            }
        }
        
        if fromClass == .assassin {
            if aimClass == .rider {
                return Fatal
            }else
                if aimClass == .caster {
                    return Weak
                }else{
                    return Other
            }
        }
        
        
        //default ···
        print("克制不明···\(fromClass)<->\(aimClass)")
        return 1.0
    }
    
}

struct campWeak {
    let Weak:CGFloat    = 0.9
    let Other:CGFloat   = 1.0
    let Fatal:CGFloat   = 1.1
    
    func campweak(fromCamp:CampType, to aimCamp:CampType) -> CGFloat {
        switch fromCamp {
        case .sky:
            if aimCamp == .earth {
                return Fatal
            }else
                if aimCamp == .man {
                    return Weak
                }else{
                    return Other
            }
        case .earth:
            if aimCamp == .man {
                return Fatal
            }else
                if aimCamp == .sky {
                    return Weak
                }else{
                    return Other
            }
        case .man:
            if aimCamp == .sky {
                return Fatal
            }else
                if aimCamp == .earth {
                    return Weak
                }else{
                    return Other
            }
        case .star:
            if aimCamp == .beast {
                return Fatal
            }else{
                return Other
            }
        case .beast:
            if aimCamp == .star {
                return Fatal
            }else{
                return Other
            }
        default:
            return Other
        }
    }
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
    let cardcorrect = cardCorrect.init()
    let positionbuff = positionBuff.init()
    let firstbuff = firstBuff.init()
    let classcorrect = classCorrect.init()
    let classweak = classWeak.init()
    let campweak = campWeak.init()
    let randomcorrect = randomCorrect.init()
    let critcorrect = critCorrect.init()
    let extrabuff = extraBuff.init()
    let busterchain = busterChain.init()
}


