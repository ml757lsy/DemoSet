//
//  CasinoViewController.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/12/25.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit
import AudioToolbox

class CasinoViewController: BaseViewController {
    
    var rollButton = UIButton()
    
    var dice1 = UILabel()
    var dice2 = UILabel()
    var dice3 = UILabel()
    
    var dices = ["⚀","⚁","⚂","⚃","⚄","⚅"]
    
    var bigButton = UIButton()
    var smallButton = UIButton()
    var iiiButton = UIButton()
    var rrrbu = UIButton()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        roll()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func initView() {
        
        dice1.frame = CGRect.init(x: 0, y: 0, width: 60, height: 60)
        dice1.font = UIFont.systemFont(ofSize: 32)
        dice1.text = "⚀"
        dice1.textColor = UIColor.red
        view.addSubview(dice1)
        
        dice2.frame = CGRect.init(x: 60, y: 0, width: 60, height: 60)
        dice2.font = UIFont.systemFont(ofSize: 32)
        dice2.text = "⚀"
        dice2.textColor = UIColor.red
        view.addSubview(dice2)
        
        dice3.frame = CGRect.init(x: 120, y: 0, width: 60, height: 60)
        dice3.font = UIFont.systemFont(ofSize: 32)
        dice3.text = "⚀"
        dice3.textColor = UIColor.red
        view.addSubview(dice3)
        
        rollButton.frame = CGRect.init(x: 20, y: 200, width: 100, height: 40)
        rollButton.setTitleColor(UIColor.red, for: .normal)
        rollButton.setTitle("摇", for: .normal)
        rollButton.addTarget(self, action: #selector(roll), for: .touchUpInside)
        view.addSubview(rollButton)
        
        bigButton.frame = CGRect.init(x: 10, y: 10, width: 100, height: 100)
        bigButton.setTitle("大", for: .normal)
        bigButton.setTitleColor(UIColor.orange, for: .normal)
        view.addSubview(bigButton)
        
        smallButton.frame = CGRect.init(x: 120, y: 10, width: 100, height: 100)
        smallButton.setTitle("小", for: .normal)
        smallButton.setTitleColor(UIColor.orange, for: .normal)
        view.addSubview(smallButton)
        
        
    }
    
    @objc func roll() {
        
        for i in 0..<2 {
            if i%2 == 1 {
                perform(#selector(stopVibration), with: nil, afterDelay: Double(i)/5)
            }else{
                perform(#selector(startVibration), with: nil, afterDelay: Double(i)/5)
            }
        }
        
        
        let a:Int = Int(arc4random()%6)+1
        let b:Int = Int(arc4random()%6)+1
        let c:Int = Int(arc4random()%6)+1
        
        dice1.text = dices[a - 1]
        dice2.text = dices[b - 1]
        dice3.text = dices[c - 1]
        
        print(a,b,c)
        
        let total = a+b+c
        
        if a==b && b==c {
            print("All")
            print(a)
        }else
            if total >= 4 && total <= 10 {
            print("Xiao")
        }else
            if total > 10 && total <= 17 {
            print("Da")
        }
    }
    
    
    @objc func startVibration() {
        AudioServicesPlaySystemSoundWithCompletion(kSystemSoundID_Vibrate) {
            //complate
        }
        
    }
    @objc func stopVibration() {
        AudioServicesRemoveSystemSoundCompletion(kSystemSoundID_Vibrate)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
