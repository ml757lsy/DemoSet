//
//  MessageFliterViewController.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/9/20.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit
import IdentityLookup

class MessageFliterViewController: BaseViewController,ILMessageFilterQueryHandling {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @available(iOS 11.0, *)
    func handle(_ queryRequest: ILMessageFilterQueryRequest, context: ILMessageFilterExtensionContext, completion: @escaping (ILMessageFilterQueryResponse) -> Void) {
        
        //
        let response = ILMessageFilterQueryResponse.init()
        response.action = .none
        
        //消息内容过滤
        let messageContent:String = queryRequest.messageBody!
        if messageContent.contains("") {
            //
            response.action = .filter
        }
        //消息发送者过滤
        let sender = queryRequest.sender!
        if sender.contains("") {
            //
            response.action = .filter
        }
    
        completion(response)
    }

}
