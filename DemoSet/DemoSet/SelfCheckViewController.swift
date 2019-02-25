//
//  SelfCheckViewController.swift
//  DemoSet
//
//  Created by 李世远 on 2018/11/22.
//  Copyright © 2018 Far. All rights reserved.
//

import UIKit
import AVKit

class SelfCheckViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkAuton()
    }
    
    func checkAuton() {
        let inputavaliable = AVAudioSession.sharedInstance().isInputAvailable
        let outputvolume = AVAudioSession.sharedInstance().outputVolume
        let a = AVAudioSession.sharedInstance().currentRoute
        for inp in a.inputs {
            print(inp.portName,convertFromAVAudioSessionPort(inp.portType))
        }
    }
    
//    func main (t:int,_:int,a:char) {
//        return!0<t?t<3?main(-79,-13,a+main(-87,1-_, main(-86,0,a+1)+a)):1,t<_?main(t+1,_,a):3,main(-94,-27+t,a)&&t==2?_<13? main(2,_+1,"%s %d %d\n"):9:16:t<0?t<-72?main(_,t, "@n'+,#'/*{}w+/w#cdnr/+,{}r/*de}+,/*{*+,/w{%+,/w#q#n+,/#{l+,/n{n+,/+#n+,/#;#q#n+,/+k#;*+,/'r :'d*'3,}{w+K w'K:'+}e#';dq#'l q#'+d'K#!/+k#;q#'r}eKK#}w'r}eKK{nl]'/#;#q#n'){)#}w'){){nl]'/+#n';d}rw' i;# ){nl]!/n{n#'; r{#w'r nc{nl]'/#{l,+'K {rw' iK{;[{nl]'/w#q#n'wk nw' iwk{KK{nl]!/w{%'l##w#' i; :{nl]'/*{q#'ld;r'}{nlwb!/*de}'c ;;{nl'-{}rw]'/+,}##'*}#nc,',#nw]'/+kd'+e}+;#'rdq#w! nr'/ ') }+}{rl#'{n' ')# }'+}##(!!/") :t<-50?_==*a?putchar(31[a]):main(-65,_,a+1):main((*a=='/')+t,_,a+1) :0<t?main(2,2,"%s"):*a=='/'||main(0,main(-61,*a, "!ek;dc i@bK'(q)-[w]*%n+r3#l,{}:\nuwloca-O;m .vpbks,fxntdCeghiry"),a+1);
//    }
    
    
    /// 检测麦克风
    func checkMic() {
        
    }
    
    /// 检测外放
    func checkSpeaker() {
        
    }
    
    func checkCamera() {
        
    }

}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromAVAudioSessionPort(_ input: AVAudioSession.Port) -> String {
	return input.rawValue
}
