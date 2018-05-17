//
//  ToDoViewController.swift
//  DemoSet
//
//  Created by 李世远 on 2018/5/8.
//  Copyright © 2018年 Far. All rights reserved.
//

import UIKit
import SnapKit

class ToDoViewController: BaseViewController {

    var list:[ToDo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initiToDoView()
        loadList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initiToDoView() {
        let vline = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        vline.backgroundColor = UIColor.black
        view.addSubview(vline)
        vline.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.bottom.equalTo(-10)
            make.width.equalTo(1)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        let timeLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        view.addSubview(timeLabel)
        timeLabel.backgroundColor = UIColor.red
        timeLabel.numberOfLines = 0
        timeLabel.text = "马\n上\n做"
        timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(vline.snp.top)
            make.right.equalTo(vline.snp.left).offset(-2)
            make.width.equalTo(18)
        }
        
        let futureLabel = UILabel.init()
        view.addSubview(futureLabel)
        futureLabel.numberOfLines = 0
        futureLabel.text = "不\n着\n急"
        futureLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(vline.snp.bottom)
            make.right.equalTo(vline.snp.left).offset(-2)
            make.width.equalTo(18)
        }
        //
        
        let hline = UIView()
        view.addSubview(hline)
        hline.backgroundColor = UIColor.black
        hline.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(view.snp.right).offset(-10)
            make.centerY.equalTo(view.snp.centerY)
        }
        
        let hadtoLabel = UILabel()
        view.addSubview(hadtoLabel)
        hadtoLabel.text = "必须做"
        hadtoLabel.snp.makeConstraints { (make) in
            make.right.equalTo(hline.snp.right)
            make.top.equalTo(hline.snp.bottom)
            make.height.equalTo(18)
        }
        
        let notlabel = UILabel()
        view.addSubview(notlabel)
        notlabel.text = "无所谓"
        notlabel.snp.makeConstraints { (make) in
            make.left.equalTo(hline.snp.left)
            make.top.equalTo(hline.snp.bottom)
            make.height.equalTo(18)
        }
    }
    
    func updateView() {
        
    }
    
    func loadList() {
        
    }
    
    func saveList() {
    }
    
    func addTodo() {
        
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

/// 待做事项
class ToDo: NSObject {
    var name:String = ""
    /// 时间 范围-1-1
    var time:CGFloat = 0
    var need:CGFloat = 0
    var view:UILabel = UILabel()
    var down:Bool = false
}
