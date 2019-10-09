//
//  TalkRobotDicListViewController.swift
//  DemoSet
//
//  Created by lishiyuan on 2019/9/3.
//  Copyright © 2019 Far. All rights reserved.
//

import UIKit

class TalkRobotDicListViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let list = UITableView.init(frame: view.bounds, style: .plain)
        view.addSubview(list)
        list.dataSource = self
        list.delegate = self
        list.register(TalkRobotDicListCell.self, forCellReuseIdentifier: "cell")
        
        let add = UIButton.init(type: .contactAdd)
        add.addTarget(self, action: #selector(toAddDic), for: .touchUpInside)
        let item = UIBarButtonItem.init(customView: add)
        navigationItem.rightBarButtonItem = item
    }
    
    func toAddDic() {
        let new = TalkRobotNewDialogueViewController.init()
        navigationController?.pushViewController(new, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TalkRobot.defaultRobot.dialogues.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dia = TalkRobot.defaultRobot.dialogues[indexPath.row]
        var keys:Array<String> = []
        var ans:Array<String> = []
        for k in dia.keys {
            keys.append(TalkRobot.defaultRobot.keywords[k])
        }
        for a in dia.answers {
            ans.append(TalkRobot.defaultRobot.answers[a])
        }
        
        let cell:TalkRobotDicListCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TalkRobotDicListCell
        cell.setKeys(keys: keys, and: ans)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var keys:[String] = []
        var ans:[String] = []
        let dia = TalkRobot.defaultRobot.dialogues[indexPath.row]
        for k in dia.keys {
            keys.append(TalkRobot.defaultRobot.keywords[k])
        }
        for a in dia.answers {
            ans.append(TalkRobot.defaultRobot.answers[a])
        }
        let detail = TalkRobotNewDialogueViewController()
        detail.keys = keys
        detail.answers = ans
        navigationController?.pushViewController(detail, animated: true)
        
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
