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
    var listData:[AppStoreContentModel] = []
    var content = AppStoreContentViewController()
    var cover:UIVisualEffectView = UIVisualEffectView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true
        
        initBaseView()
        loadData()
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
        listTable.frame = CGRect.init(x: 0, y: 0, width: view.width, height: view.height)
        listTable.separatorStyle = .none
        listTable.delegate = self
        listTable.dataSource = self
        view.addSubview(listTable)
        listTable.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(0)
        }
        
        content = AppStoreContentViewController()
        
        //遮罩 暂时隐藏
        let blur = UIBlurEffect.init(style: .regular)
        cover = UIVisualEffectView.init(effect: blur)
        cover.alpha = 1
        cover.frame = view.bounds
        view.addSubview(cover)
        cover.isHidden = true
    }
    
    func loadData() {
        
        for _ in 0..<10 {
            listData.append(AppStoreContentModel())
        }
        listTable.reloadData()
    }
    
    //MARK: -
    /// 收起tabbar和顶部状态栏
    func hidenTopAndBottom() {
        UIView.animate(withDuration: 0.4, animations: {
            for v in (self.tabBarController?.view.subviews)! {
                if v.isKind(of: UITabBar.self){
                    v.frame = CGRect.init(x: 0, y: SCREENHEIGHT, width: v.width, height: v.height)
                }else if v.isKind(of: NSClassFromString("UITransitionView")!) {
                    v.frame = CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT)
                    self.view.frame = v.frame
                }
            }
            //
            self.cover.alpha = 1
            self.cover.isHidden = false
        }) { (t) in
            self.tabBarController?.tabBar.isHidden = true
        }
        
        hidenStatusBar = true
        UIView.animate(withDuration: 0.4) {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    /// 显示tabbar和顶部状态栏
    func showTopAndBottom() {
        self.tabBarController?.tabBar.isHidden = false
        UIView.animate(withDuration: 0.4) {
            self.cover.alpha = 0
            self.cover.isHidden = true
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
    
    func gotoNext(with cell:UITableViewCell?) {
        cell?.setHighlighted(false, animated: true)
        hidenTopAndBottom()
        //
        content.closeBlock = {
            self.showTopAndBottom()
            UIView.animate(withDuration: 0.2, animations: {
                cell?.setHighlighted(true, animated: true)
            }, completion: { (t) in
                cell?.setHighlighted(false, animated: true)
            })
        }
        
        present(content, animated: false) {
            self.hidenTopAndBottom()
        }
    }
    
    //MARK: - tableview delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AppStoreContentCell.init(style: .default, reuseIdentifier: "")
        cell.model = listData[indexPath.row]
        cell.clipsToBounds = true
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var rect = tableView.rectForRow(at: indexPath)
        let cell = tableView.cellForRow(at: indexPath)
        
        rect.origin.x += 20
        rect.size.width -= 40
        rect.origin.y += 10
        rect.size.height -= 20
        
        //
        content.model = listData[indexPath.row]
        content.fromFrame = tableView.convert(rect, to: view)
        content.modalPresentationStyle = .overCurrentContext
        
        cell?.setHighlighted(true, animated: true)
        perform(#selector(gotoNext(with:)), with: cell, afterDelay: 0.2)
    }

}
