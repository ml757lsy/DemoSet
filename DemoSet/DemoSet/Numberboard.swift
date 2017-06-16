//
//  Numberboard.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/6/16.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit

class Numberboard: UIView,UIPickerViewDataSource,UIPickerViewDelegate {
    // MARK: - 属性值private
    private var num:CGFloat = 1
    private var fon:UIFont = UIFont.systemFont(ofSize: 20)
    private var board:UIPickerView = UIPickerView()
    private var integer:Int = 0
    private var decimal:Int = 0
    private var point:UIView = UIView()
    
    // MARK: - 对外接口
    var number:CGFloat{
        get{
            return num
        }
        set(newValue){
            changeNumer(num: newValue)
            
            num = newValue
        }
    }
    
    var font:UIFont {
        get{
            return fon
        }
        set(newValue){
            fon = newValue
            updateView()
        }
    }
    
    // MARK: - 生命周期与复写
    override init(frame: CGRect){
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - 界面布局
    private func initView(){
        addSubview(board)
        board.frame = CGRect.init(x: 0, y: 0, width: 400, height: 80)
        board.delegate = self
        board.dataSource = self
        
        addSubview(point)
        point.frame = CGRect.init(x: 0, y: 75, width: 4, height: 4)
        point.backgroundColor = UIColor.gray
    }

    private func changeNumer(num:CGFloat) {
        let numstring = "\(num)"
        let numArr = numstring.components(separatedBy: ".")
        
        if numArr[0].hasPrefix("-") {
            //负数
            integer = numArr[0].lengthOfBytes(using: .utf8)-1
        }else{
            integer = numArr[0].lengthOfBytes(using: .utf8)
        }
        
        if numArr[1].lengthOfBytes(using: .utf8) == 1 {
            if numArr[1] == "0" {
                decimal = 0
            }else{
                decimal = 1
            }
        }else{
            decimal = numArr[1].lengthOfBytes(using: .utf8)
        }
        updateView()
        
    }
    
    private func updateView() {
        if decimal > 0 {
            point.x = 120
            point.isHidden = false
        }else{
            point.isHidden = true
        }
        
        board.reloadAllComponents()
    }
    
    // MARK: - 功能函数
    
    // MARK: - 代理方法
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return integer + decimal
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 40
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 80
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.frame = CGRect.init(x: 0, y: 0, width: 40, height: 80)
        label.text = "\(row)"
        label.font = font
        label.layer.borderWidth = 1
        return label
    }
    
    // MARK: - 其他

}
