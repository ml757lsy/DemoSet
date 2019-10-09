//
//  TalkRobotNewDialogueViewController.swift
//  DemoSet
//
//  Created by lishiyuan on 2019/9/6.
//  Copyright © 2019 Far. All rights reserved.
//

import UIKit

class TalkRobotNewDialogueViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate{
    
    var table = UITableView.init()
    var keys:[String] = []
    var answers:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initView()
    }
    
    
    func initView() {
        let save = UIButton.init(type: .system)
        save.setTitle("Save", for: .normal)
        save.addTarget(self, action: #selector(saveBtnClick), for: .touchUpInside)
        let item = UIBarButtonItem.init(customView: save)
        navigationItem.rightBarButtonItem = item
        
        table = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT), style: .grouped)
        view.addSubview(table)
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "tab")
        table.isEditing = true
        
        //add key
        
        //add answer
    }
    
    @objc func saveBtnClick() {
        print("save")
    }
    
    @objc func addKeyBtnClick() {
        print("addkey")
        let a = UIAlertController.init(title: "AddKey", message: "", preferredStyle: .alert)
        a.addTextField { (text) in
            //
            text.textColor = UIColor.red
            text.delegate = self
        }
        present(a, animated: true) {
            //
        }
    }
    
    @objc func addAnswerBtnClick() {
        print("addAns")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return keys.count
        }else{
            return answers.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 40))
        v.backgroundColor = UIColor.lightGray
        if section == 0 {
            //key
            let kb = UIButton.init(type: .system)
            kb.frame = CGRect.init(x: SCREENWIDTH-100, y: 0, width: 100, height: 40)
            kb.setTitle("AddKey", for: .normal)
            kb.addTarget(self, action: #selector(addKeyBtnClick), for: .touchUpInside)
            v.addSubview(kb)
        }else{
            let ab = UIButton.init(type: .system)
            ab.frame = CGRect.init(x: SCREENWIDTH-100, y: 0, width: 100, height: 40)
            ab.setTitle("AddAnswer", for: .normal)
            ab.addTarget(self, action: #selector(addAnswerBtnClick), for: .touchUpInside)
            v.addSubview(ab)
        }
        return v
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tab")
        if indexPath.section == 0 {
            cell?.textLabel?.text = keys[indexPath.row]
        }else {
            cell?.textLabel?.text = answers[indexPath.row]
        }
        cell?.textLabel?.textColor = UIColor.randomColor()
        return cell!
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            //
            keys.remove(at: indexPath.row)
        }else {
            answers.remove(at: indexPath.row)
        }
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    //textfi
    func textFieldDidEndEditing(_ textField: UITextField) {
        //
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
