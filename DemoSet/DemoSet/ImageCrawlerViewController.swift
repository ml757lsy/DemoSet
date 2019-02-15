//
//  ImageCrawlerViewController.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/8/25.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit
import Alamofire
import HandyJSON

/// 爬图脚本
class ImageCrawlerViewController: BaseViewController {

    var tmpData:Data?//缓存数据用
    
    let queue:OperationQueue = {
        let que:OperationQueue = OperationQueue()
        que.maxConcurrentOperationCount = 1
        return que
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }
    
    func initView() {
        let crawler = UIButton.init(type: .system)
        crawler.frame = CGRect.init(x: 10, y: 40, width: 60, height: 40)
        crawler.setTitle("Crawler", for: .normal)
        crawler.addTarget(self, action: #selector(toCrawler), for: .touchUpInside)
        view.addSubview(crawler)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    func toCrawler() {
//        let url:URL = URL.init(string: "http://bbs.ngacn.cc/read.php?tid=9462385")!
//        let sk = "[img]"
//        let ek = "[/img]"
        
        let url:URL = URL.init(string: "http://fgowiki.com/archives/12028#wu")!
        
        Alamofire.request(url).responseString { (string) in
            let str:NSString = string.result.value! as NSString
//            print(str)
            
            let list = self.getUrl(str: str)
            
            for url in list {
                print(url)
                let name = self.getName(url: url)
                self.download(url: url, name: name, progress: { (progress) in
                    //
                    print(progress)
                })
            }
        }
    }
    
    /// 去下载
    ///
    /// - Parameters:
    ///   - url: url
    ///   - name: name
    ///   - progress: pro
    func download(url:String,name:String,progress:@escaping BaseBlockCGFloat) {
        let semaphore = DispatchSemaphore.init(value: 0)
        let op = BlockOperation {
            
//            if self.tmpData != nil {//断点续传
//                Alamofire.download(resumingWith: self.tmpData!)
//            }
            
            //
            Alamofire.download(URL.init(string: url)!, method: HTTPMethod.get, parameters: nil, encoding: URLEncoding.default, headers: nil) { (url, response) -> (destinationURL: URL, options: DownloadRequest.DownloadOptions) in
                
                var path = String(describing : NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, false)[0]+name)
                
                if path.hasPrefix("~") {
                    //mac 设置保存地址
                    path = "/Users/lishiyuan/Documents/temp/crawler/" + name
                }
                
                return (URL(fileURLWithPath: path), [.createIntermediateDirectories, .removePreviousFile])
                }.downloadProgress(closure: { (pro) in
                    //进度
                    let p = CGFloat(pro.completedUnitCount)/CGFloat(pro.totalUnitCount)
                    
                    progress(p)
                    
                }).responseJSON { (response) in
                    
                    switch response.result {
                        
                    case .success:
                        print("success")
                    case .failure:
                        //意外中断后在此处处理下载完成的部分
                        self.tmpData = response.resumeData
                        
                    default:
                        print("failed")
                    }
                    semaphore.signal()
            }
            semaphore.wait()
        }
        queue.addOperation(op)
    }
    
    /// 获取地址列表
    ///
    /// - Parameter str: 原文
    /// - Returns: [String]
    func getUrl(str:NSString) -> [String] {
        var list:[String] = []
        
        //标签
        let sk = "src=\""
        let ek = "\""
        
        list = self.getKey(str: str, start: sk, end: ek)
        
        for k in list {
            if !self.isImageUrl(url: k) {
                let index = list.firstIndex(of: k)
                list.remove(at: index!)
            }
        }
        
        return list
    }
    
    func getHref(str:NSString) -> [String] {
        
        let sk = "href=\""
        let ek = "\""
        
        var list = getKey(str: str, start: sk, end: ek)
        
        for k in list {
            if self.isImageUrl(url: k) {
                let index = list.firstIndex(of: k)
                list.remove(at: index!)
            }
        }
        
        return list
    }
    
    /// 根据关键值获取夹层值
    ///
    /// - Parameters:
    ///   - str: 原文
    ///   - start: 左值
    ///   - end: 右值
    /// - Returns: [String]
    func getKey(str:NSString,start:String,end:String) -> [String] {
        var list:[String] = []
        
        var index:Int = 0
        //标签
        let sk = start
        let ek = end
        
        while index < str.length - 5 {
            let start = str.substring(with: NSRange.init(location: index, length: sk.count))
            if start.lowercased().elementsEqual(sk) {
                for i in index+sk.count..<str.length {
                    let end = str.substring(with: NSRange.init(location: i, length: ek.count))
                    if end.lowercased().elementsEqual(ek) {
                        let url = str.substring(with: NSRange.init(location: index+sk.count, length: i-index-sk.count))
                        
                        list.append(url)
                        
                        index = i+6
                        break
                    }
                }
            }else{
                index += 1
            }
        }
        
        return list
    }
    
    /// 判断图片
    ///
    /// - Parameter url: 地址
    /// - Returns: 是否
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
    
    /// 截取名字
    ///
    /// - Parameter url: url
    /// - Returns: 名字
    func getName(url:String) -> String {
        let list = url.components(separatedBy: "/")
        if list.count > 0 {
            return list.last!
        }else{
            return ""
        }
    }

}

class UserList:NetworkModel {
    var list:[UserModel] = []
}

class UserModel:NetworkModel {
    
    var id:Int = 0
    var name:String = ""
    var type:Int = 0
}


