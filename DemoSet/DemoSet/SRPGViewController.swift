//
//  SRPGViewController.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/11/28.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit

class SRPGViewController: BaseViewController {

    var mapdata:[[Int]] = []
    var mapview:[[UILabel]] = []
    let w = 20;
    let h = 20;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        astar()
    }
    
    func astar () {
        
    }
    
    func layoutmap() {
        for _ in 0..<h {
            var line:[Int] = []
            var linev:[UILabel] = []
            for _ in 0..<w {
                let n = arc4random()%5;
                line.append(Int(n))
                let label = UILabel()
                label.text = "\(n)"
                linev.append(label)
            }
            mapdata.append(line)
            mapview.append(linev)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    /*
     */

}
