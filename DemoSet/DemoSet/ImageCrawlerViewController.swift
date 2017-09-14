//
//  ImageCrawlerViewController.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/8/25.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit
import Alamofire

class ImageCrawlerViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        crawler()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func crawler() {
        let url:URL = URL.init(string: "http://bbs.ngacn.cc/read.php?tid=9462385")!
        
        Alamofire.request(url).responseString { (string) in
            let str:String = string.result.value!
            let range = str.range(of: "[img]")
            print(range)
        }
    }

}
