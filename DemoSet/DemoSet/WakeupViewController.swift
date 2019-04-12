//
//  WakeupViewController.swift
//  DemoSet
//
//  Created by 李世远 on 2018/7/6.
//  Copyright © 2018年 Far. All rights reserved.
//

import UIKit

class WakeupViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let open = UIButton.init(type: .system)
        view.addSubview(open)
        open.frame = CGRect.init(x: 40, y: 40, width: 60, height: 40)
        open.setTitle("chidiansha", for: .normal)
        open.addTarget(self, action: #selector(openHaohaochifan), for: .touchUpInside)
        
        let kakao = UIButton.init(type: .system)
        view.addSubview(kakao)
        kakao.frame = CGRect.init(x: 40, y: 100, width: 60, height: 40)
        kakao.setTitle("kakao", for: .normal)
        kakao.addTarget(self, action: #selector(openKakao), for: .touchUpInside)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func openHaohaochifan() {
        let url = URL.init(string: "chidiansha://")
        let options:[UIApplication.OpenExternalURLOptionsKey:Any] = [:]
        UIApplication.shared.open(url!, options: options) { (success) in
            //
        }
    }
    
    @objc func openKakao() {
        let url = URL.init(string: "kakaolink://")
        let options:[UIApplication.OpenExternalURLOptionsKey:Any] = [:]
        UIApplication.shared.open(url!, options: options) { (success) in
            //
        }
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
