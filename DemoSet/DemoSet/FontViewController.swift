//
//  FontViewController.swift
//  DemoSet
//
//  Created by 李世远 on 2018/7/26.
//  Copyright © 2018年 Far. All rights reserved.
//

import UIKit

class FontViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    var familynames:[String] = []
    var fontnames:[[String]] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        familynames = UIFont.familyNames
        for family in familynames {
            fontnames.append(UIFont.fontNames(forFamilyName: family))
        }
        
        let table = UITableView.init()
        view.addSubview(table)
        table.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(0);
        }
        table.dataSource = self;
        table.delegate = self;
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return familynames.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fontnames[section].count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel.init()
        label.text = familynames[section]
        label.font = UIFont.init(name: familynames[section], size: 18)
        label.textColor = UIColor.red
        label.backgroundColor = UIColor.white
        
        return label
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        let name = fontnames[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.numberOfLines = 0
        cell?.textLabel?.text = name+"\n123abcXYZ一呵하!@#$%&*("
        cell?.textLabel?.font = UIFont.init(name: name, size: 18)
        
        return cell!
    }

}
