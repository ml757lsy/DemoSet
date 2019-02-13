//
//  ImmortalViewController.swift
//  DemoSet
//
//  Created by 李世远 on 2019/1/22.
//  Copyright © 2019 Far. All rights reserved.
//

import UIKit

class ImmortalViewController: BaseViewController {

    var timer:CADisplayLink = CADisplayLink()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        loadMai()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeTimer()
        super.viewWillDisappear(animated)
    }
    
    func loadMai() {
        
        loadTimer()
    }
    
    func loadTimer() {
        timer = CADisplayLink.init(target: self, selector: #selector(timerHandler))
        timer.add(to: RunLoop.current, forMode: .defaultRunLoopMode)
    }
    
    func removeTimer() {
        timer.invalidate()
    }
    
    func timerHandler() {
        print(timer.duration)
    }
    
    func yun() {
        
    }
    
    func xing() {
        //
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
