//
//  TalkRobotViewController.swift
//  DemoSet
//
//  Created by lishiyuan on 2019/8/28.
//  Copyright © 2019 Far. All rights reserved.
//

import UIKit

class TalkRobotViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let s = TalkRobot.defaultRobot.answer(something: "ca")
        print(s)
        
        let label = UILabel.init(frame: view.bounds)
        view.addSubview(label)
        
        label.text = s
        
        //
        let diclist = UIButton.init(type: .detailDisclosure)
        diclist.addTarget(self, action: #selector(toDicListVC), for: .touchUpInside)
        let item = UIBarButtonItem.init(customView: diclist)
        navigationItem.rightBarButtonItem = item
    }
    
    @objc func toDicListVC() {
        let dl = TalkRobotDicListViewController.init()
        navigationController?.pushViewController(dl, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
