//
//  ImageCrawlerViewController.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/8/25.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit
import Alamofire

/// 爬图脚本
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
//        let url:URL = URL.init(string: "http://bbs.ngacn.cc/read.php?tid=9462385")!
//        let sk = "[img]"
//        let ek = "[/img]"
        
        let url:URL = URL.init(string: "http://fgowiki.com/archives/12028#wu")!
        let sk = "src=\""
        let ek = "\""
        
        Alamofire.request(url).responseString { (string) in
            let str:NSString = string.result.value! as NSString
//            print(str)
            
            var index:Int = 0
            while index < str.length - 5 {
                let start = str.substring(with: NSRange.init(location: index, length: sk.count))
                if start.lowercased().elementsEqual(sk) {
                    for i in index+sk.count..<str.length {
                        let end = str.substring(with: NSRange.init(location: i, length: ek.count))
                        if end.lowercased().elementsEqual(ek) {
                            let url = str.substring(with: NSRange.init(location: index+sk.count, length: i-index-sk.count))

                            if self.isImageUrl(url: url) {
                                print(url)
                            }
                            
                            index = i+6
                            break
                        }
                    }
                }else{
                    index += 1
                }
            }
            
            //
        }
    }
    
    func isImageUrl(url:String) -> Bool {
        if url.hasSuffix(".jpg") {
            return true
        }
        
        if url.hasSuffix(".jpeg") {
            return true
        }
        
        if url.hasSuffix(".png") {
            return true
        }
        
        if url.hasSuffix(".gif") {
            return true
        }
        
        return false
    }

}
