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
            print(inp.portName,inp.portType)
        }
    }
    
    
    /// 检测麦克风
    func checkMic() {
        
    }
    
    /// 检测外放
    func checkSpeaker() {
        
    }
    
    func checkCamera() {
        
    }

}
