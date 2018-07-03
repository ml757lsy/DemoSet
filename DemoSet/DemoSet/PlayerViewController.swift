//
//  PlayerViewController.swift
//  DemoSet
//
//  Created by 李世远 on 2018/6/28.
//  Copyright © 2018年 Far. All rights reserved.
//

import UIKit

class PlayerViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    var playList:[String] = []
    var current:Int = 0
    private let listTable:UITableView = UITableView.init()
    private let manager = PlayerManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initView()
        initNav()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        manager.stop()
    }
    
    func initView() {
        view.addSubview(manager.view)
        manager.view.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(0)
        }
        manager.view.backgroundColor = UIColor.lightGray
        
        //list
        view.addSubview(listTable)
        listTable.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(0)
            make.right.equalTo(150)
            make.width.equalTo(150)
        }
        listTable.dataSource = self
        listTable.delegate = self
        listTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        listTable.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.3)
    }
    
    func initNav() {
        let show = UIButton.init(type: .system)
        show.setTitle("List", for: .normal)
        show.frame = CGRect.init(x: 0, y: 0, width: 44, height: 44)
        show.addTarget(self, action: #selector(showList), for: .touchUpInside)
        
        let right = UIBarButtonItem.init(customView: show)
        navigationItem.rightBarButtonItem = right
        
    }
    
    //MARK: - func
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        get{
            print("TTTTTT")
            return super.preferredInterfaceOrientationForPresentation
        }
    }
    
    func play(index:Int) {
        closeList()
        let path = playList[index]
        manager.loadVideo(with: path)
    }
    
    func showList() {
        listTable.snp.updateConstraints { (make) in
            make.right.equalTo(0)
        }
        UIView.animate(withDuration: 0.8) {
            self.listTable.alpha = 1
            self.listTable.layoutIfNeeded()
        }
    }
    
    func closeList() {
        
        listTable.snp.updateConstraints { (make) in
            make.right.equalTo(150)
        }
        UIView.animate(withDuration: 0.8) {
            self.listTable.alpha = 0
            self.listTable.layoutIfNeeded()
        }
    }

    //MARK: - delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = (playList[indexPath.row] as NSString).lastPathComponent
        if indexPath.row == current {
            cell.textLabel?.textColor = UIColor.red
        }else{
            cell.textLabel?.textColor = UIColor.white
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        play(index: indexPath.row)
    }
}
