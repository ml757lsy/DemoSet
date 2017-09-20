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

        // Do any additional setup after loading the view.
        if #available(iOS 11.0, *) {
            let action = ILMessageFilterAction.allow
            
            
            let fliter = ILMessageFilterExtension.init()
        } else {
            // Fallback on earlier versions
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @available(iOS 11.0, *)
    func handle(_ queryRequest: ILMessageFilterQueryRequest, context: ILMessageFilterExtensionContext, completion: @escaping (ILMessageFilterQueryResponse) -> Void) {
        
        let response = ILMessageFilterQueryResponse.init()
        
        completion(response)
        
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
