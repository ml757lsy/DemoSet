//
//  CalculatorAbbreviationView.swift
//  DemoSet
//
//  Created by 李世远 on 2018/11/12.
//  Copyright © 2018年 Far. All rights reserved.
//

import UIKit

class CalculatorAbbreviationView: UIView {
    
    private let income:UITextField = UITextField.init()
    private let socialsecurity:UITextField = UITextField.init()
    private let output:UILabel = UILabel.init()
    private let submit:UIButton = UIButton.init(type: .system)
    /*
     级数    应纳税所得额(含税)    应纳税所得额(不含税)    税率(%)    速算扣除数
     1    不超过3,000元的部分    不超过2,910元的部分    3    0
     2    超过3,000元至12,000元的部分    超过2,910元至11,010元的部分    10    210
     3    超过12,000元至25,000元的部分    超过11,010元至21,410元的部分    20    1410
     4    超过25,000元至35,000元的部分    超过21,410元至28,910元的部分    25    2660
     5    超过35,000元至55,000元的部分    超过28,910元至42,910元的部分    30    4410
     6    超过55,000元至80,000元的部分    超过42,910元至59,160元的部分    35    7160
     7    超过80,000元的部分    超过59,160元的部分    45    15160
     */
    private var stage:[Double] = []
    private var tax:[Double] = []
    private var fit:[Double] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView() {
        stage.append(5000)
        stage.append(12000)
        stage.append(25000)
        stage.append(35000)
        stage.append(55000)
        stage.append(80000)
        
        tax.append(0.03)
        tax.append(0.10)
        tax.append(0.20)
        tax.append(0.25)
        tax.append(0.30)
        tax.append(0.35)
        tax.append(0.45)
        
        fit.append(0)
        fit.append(210)
        fit.append(1410)
        fit.append(2660)
        fit.append(4410)
        fit.append(7160)
        fit.append(15160)
        
        //
        self.backgroundColor = UIColor.white
        
        self.addSubview(income)
        income.borderStyle = .roundedRect
        income.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.top.equalTo(40)
            make.right.equalTo(-40)
            make.height.equalTo(40)
        }
        
        self.addSubview(socialsecurity)
        socialsecurity.borderStyle = .roundedRect
        socialsecurity.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.top.equalTo(income.snp.bottom).offset(40)
            make.right.equalTo(-40)
            make.height.equalTo(40)
        }
        
        self.addSubview(output)
        output.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.top.equalTo(socialsecurity.snp.bottom).offset(40)
            make.right.equalTo(-40)
            make.height.equalTo(40)
        }
        
        self.addSubview(submit)
        submit.setTitle("计算", for: .normal)
        submit.addTarget(self, action: #selector(submitClick), for: .touchUpInside)
        submit.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.top.equalTo(output.snp.bottom).offset(40)
            make.right.equalTo(-40)
            make.height.equalTo(40)
        }
    }
    
    func submitClick() {
        let n = income.text
        let ss = socialsecurity.text
        var num:Double = 0
        
        if n != nil {
            num = Double(n!)!
            num -= 5000
        }
        
        if ss != nil {
            num -= Double(ss!)!
        }
        
        var index:Int = 0
        for st in stage {
            if num > st {
                index += 1
            }
        }
        
        let s = fit[index]
        let t = num * tax[index] - s
        
        output.text = String.init(format: "%f", t)
        print(t)
    }
    
}
