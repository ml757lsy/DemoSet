//
//  CollectionBoxViewController.swift
//  DemoSet
//
//  Created by 李世远 on 2018/8/3.
//  Copyright © 2018年 Far. All rights reserved.
//

import UIKit

/// 传说中的开箱子
class CollectionBoxViewController: BaseViewController {
    
    var curt:[Int] = []//暂存数据用来比较
    var sub:[Int] = [0,0,0,0,0]
    
    let stage1 = UILabel.init(frame: CGRect.zero)
    let stage2 = UILabel.init(frame: CGRect.zero)
    let stage3 = UILabel.init(frame: CGRect.zero)
    let stage4 = UILabel.init(frame: CGRect.zero)
    let stagehad = UILabel.init(frame: CGRect.zero)

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView() {
        let box = UIButton.init(type: .system)
        box.frame = CGRect.init(x: 0, y: 0, width: 100, height: 40)
        box.setTitle("Box", for: .normal)
        view.addSubview(box)
        box.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
        }
        box.addTarget(self, action: #selector(boxClick), for: .touchUpInside)
        
        let check = UIButton.init(type: .system)
        check.frame = CGRect.init(x: 0, y: 150, width: 100, height: 40)
        check.setTitle("Check", for: .normal)
        view.addSubview(check)
        check.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(100)
        }
        check.addTarget(self, action: #selector(checkClick), for: .touchUpInside)
        
        view.addSubview(stage1)
        stage1.frame = CGRect.init(x: 40, y: 200, width: 10, height: 40)
        stage1.backgroundColor = UIColor.red
        
        view.addSubview(stage2)
        stage2.frame = CGRect.init(x: 40, y: 250, width: 10, height: 40)
        stage2.backgroundColor = UIColor.orange
        
        view.addSubview(stage3)
        stage3.frame = CGRect.init(x: 40, y: 300, width: 10, height: 40)
        stage3.backgroundColor = UIColor.green
        
        view.addSubview(stage4)
        stage4.frame = CGRect.init(x: 40, y: 350, width: 10, height: 40)
        stage4.backgroundColor = UIColor.blue
        
        view.addSubview(stagehad)
        stagehad.frame = CGRect.init(x: 40, y: 400, width: 10, height: 40)
        stagehad.backgroundColor = UIColor.yellow
    }
    
    func checkClick() {
        Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(boxClick), userInfo: nil, repeats: true)
    }
    
    func boxClick() {
        //
        let num = arc4random()%10000
        let n1 = 100
        let n2 = 400
        let n3 = 500
        
        var result = 10
        
        if num < n1 {
            //n1
//            print("===!1!===")
            result = 1
            sub[0] += 1
        }else if num < n2+n1 {
            //n2
//            print("---2---")
            result = 2
            sub[1] += 1
        }else if num < n3+n2+n1 {
            //n3
//            print("...3...")
            result = 3
            sub[2] += 1
        }else{
            //other
//            print("4")
            result = 4
            sub[3] += 1
        }
        
        if curt.count >= 5 {
            curt.remove(at: 0)
        }
        
        var had = false
        if result <= 3 {
            for i in curt {
                if i <= 3 {
                    had = true
                    break
                }
            }
        }
        curt.append(result)
        
        if had {//玄学的计算
            //
            sub[4] += 1
        }
        stage1.text = String(format: "%d", sub[0])
        stage2.text = String(format: "%d", sub[1])
        stage3.text = String(format: "%d", sub[2])
        stage4.text = String(format: "%d", sub[3])
        stagehad.text = String(format: "%d", sub[4])
        
        let maxw:CGFloat = 200
        let total:Int = sub[0]+sub[1]+sub[2]+sub[3]
        let t1 = CGFloat(sub[0])/CGFloat(total)*maxw
        let t2 = CGFloat(sub[1])/CGFloat(total)*maxw
        let t3 = CGFloat(sub[2])/CGFloat(total)*maxw
        let t4 = CGFloat(sub[3])/CGFloat(total)*maxw
        var t = total - sub[3]
        if t == 0 {
            t = 1
        }
        let th = CGFloat(sub[4])/CGFloat(t)*maxw
        stage1.width = t1
        stage2.width = t2
        stage3.width = t3
        stage4.width = t4
        stagehad.width = th
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
