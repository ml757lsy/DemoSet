//
//  ReaderViewController.swift
//  DemoSet
//
//  Created by 李世远 on 2018/5/17.
//  Copyright © 2018年 Far. All rights reserved.
//

import UIKit

class ReaderViewController: BaseViewController {
    
    var list:[UIImage] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView() {
        let banner = BaseBannerView.init(frame: CGRect.init(x: 10, y: 10, width: view.frame.size.width-20, height: 200))
        banner.images = ["banner1","banner2","banner3","banner4","banner5","banner6",]
        view.addSubview(banner)
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
