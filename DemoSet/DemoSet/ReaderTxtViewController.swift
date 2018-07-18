//
//  ReaderTxtViewController.swift
//  DemoSet
//
//  Created by 李世远 on 2018/7/18.
//  Copyright © 2018年 Far. All rights reserved.
//

import UIKit

class ReaderTxtViewController: BaseViewController {
    
    /// 传递路径
    var path = ""

    private var text = UITextView.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(text);
        text.backgroundColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.8);
        text.font = UIFont.systemFont(ofSize: 16)
        text.snp.makeConstraints { (make) in
            make.top.left.equalTo(5)
            make.right.bottom.equalTo(-5);
        }
        
        loadText()
        
    }
    
    func loadText() {
        //load
        DispatchQueue.global().async {
            do {
                let string = try String.init(contentsOfFile: self.path)
                DispatchQueue.main.async {
                    self.text.text = string
                }
            } catch let error {
                print(error)
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
