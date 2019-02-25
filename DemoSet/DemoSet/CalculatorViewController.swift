//
//  CalculatorViewController.swift
//  DemoSet
//
//  Created by 李世远 on 2018/11/12.
//  Copyright © 2018年 Far. All rights reserved.
//

import UIKit

/// 计算器相关
class CalculatorViewController: BaseViewController {

    private let abbreviation:CalculatorAbbreviationView = CalculatorAbbreviationView.init(frame: CGRect.zero)
    private let bignumber:CalculatorBignumberView = CalculatorBignumberView.init(frame: CGRect.zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView() {
        var list:[String] = []
        list.append("Abbreviation")
        list.append("Bignumber")
        
        var index = 0
        for name in list {
            let typybtn = UIButton.init(type: .system)
            typybtn.frame = CGRect.init(x: 40, y: 40 + index * 60, width: 200, height: 40)
            typybtn.setTitle(name, for: .normal)
            typybtn.addTarget(self, action: #selector(typeButtonClick(btn:)), for: .touchUpInside)
            view.addSubview(typybtn)
            
            index += 1
            typybtn.tag = index
        }
        
        //
        view.addSubview(abbreviation)
        abbreviation.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(0)
        }
        abbreviation.isHidden = true
        
        view.addSubview(bignumber)
        bignumber.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(0)
        }
        bignumber.isHidden = true
        
    }
    
    @objc func typeButtonClick(btn:UIButton) {
        switch btn.tag {
        case 1:
            abbreviation.isHidden = false
            bignumber.isHidden = true
            break
        case 2:
            abbreviation.isHidden = true
            bignumber.isHidden = false
            break
        default:
            break
        }
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
