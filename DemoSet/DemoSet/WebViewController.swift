//
//  WebViewController.swift
//  DemoSet
//
//  Created by 李世远 on 2018/5/14.
//  Copyright © 2018年 Far. All rights reserved.
//

import UIKit

class WebViewController: BaseViewController,UIWebViewDelegate {
    
    let web = UIWebView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initWebView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initWebView() {
        web.frame = view.bounds
        view.addSubview(web)
        
        
        let request = URLRequest.init(url: URL.init(string: "https://www.rule34hentai.net/image/265844.webm")!)
        web.loadRequest(request)
        web.delegate = self
        
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        print("Should")
        return true
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        print("start")
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print("finish")
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print("ERROR")
        print(error)
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
