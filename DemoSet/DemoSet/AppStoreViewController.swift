//
//  AppStoreViewController.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/12/5.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit

/// 类似App Store的动效
class AppStoreViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    var hidenStatusBar = false
    var listTable:UITableView = UITableView()
    var listData:[String] = []
    var content = AppStoreContentViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true
        
        initBaseView()
//        hidenTopAndBottom()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showTopAndBottom()
    }
    
    override var prefersStatusBarHidden: Bool {
        get{
            return hidenStatusBar
        }
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        get{
            return .slide
        }
    }
    
    func initBaseView() {
        //
        for i in 0..<10 {
            listData.append("1")
        }
        
        
        
        listTable.frame = CGRect.init(x: 20, y: 0, width: view.width-40, height: view.height)
        listTable.delegate = self
        listTable.dataSource = self
        view.addSubview(listTable)
        
        listTable.reloadData()
        
        content = AppStoreContentViewController()
    }
    
    
    func hidenTopAndBottom() {
        
        UIView.animate(withDuration: 0.4) {
            for v in (self.tabBarController?.view.subviews)! {
                if v.isKind(of: UITabBar.self){
                    v.frame = CGRect.init(x: 0, y: SCREENHEIGHT, width: v.width, height: v.height)
                }else if v.isKind(of: NSClassFromString("UITransitionView")!) {
                    v.frame = CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT)
                    self.view.frame = v.frame
                }
            }
        }
        
        hidenStatusBar = true
        UIView.animate(withDuration: 0.4) {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    func showTopAndBottom() {
        UIView.animate(withDuration: 0.4) {
            for v in (self.tabBarController?.view.subviews)! {
                if v.isKind(of: UITabBar.self){
                    v.frame = CGRect.init(x: 0, y: SCREENHEIGHT - v.height, width: v.width, height: v.height)
                }else if v.isKind(of: NSClassFromString("UITransitionView")!) {
                    v.frame = CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: self.view.height)
                    self.view.frame = v.frame
                }
            }
        }
        
        hidenStatusBar = false
        UIView.animate(withDuration: 0.4) {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
  
    
    override func setNeedsStatusBarAppearanceUpdate() {
        self.tabBarController?.setNeedsStatusBarAppearanceUpdate()
    }
    
    //
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AppStoreContentCell.init(style: .default, reuseIdentifier: "")
        cell.backgroundColor = UIColor.randomColor()
        cell.clipsToBounds = true
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rect = tableView.rectForRow(at: indexPath)
        let cell = tableView.cellForRow(at: indexPath)
        
        content.content.backgroundColor = cell?.backgroundColor
        content.fromFrame = tableView.convert(rect, to: view)
        content.modalPresentationStyle = .overCurrentContext
        hidenTopAndBottom()
        content.closeBlock = {
            self.showTopAndBottom()
        }

        present(content, animated: false) {
            self.hidenTopAndBottom()
        }
    }

}
