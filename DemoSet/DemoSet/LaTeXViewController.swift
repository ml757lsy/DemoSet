//
//  LaTeXViewController.swift
//  DemoSet
//
//  Created by lishiyuan on 2020/1/10.
//  Copyright © 2020 Far. All rights reserved.
//

import UIKit
import MathEditor

/// 展示和编辑数学公式
class LaTeXViewController: BaseViewController,UITextFieldDelegate,MTEditableMathLabelDelegate {

    var editorHeight:CGFloat = 64;
    var mtlabel:MTMathUILabel = MTMathUILabel()
    let showLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initView()
    }
    
    func initView() {
        
        mtlabel.frame = CGRect.init(x: 40, y: 10, width: view.width-80, height: 64)
        mtlabel.labelMode = .text
        mtlabel.textAlignment = .left
        mtlabel.fontSize = 25
        mtlabel.latex = "x = \\frac{-b \\pm \\sqrt{b^2-4ac}}{2a}"
        mtlabel.backgroundColor = .white
        mtlabel.sizeToFit()
        view.addSubview(mtlabel)
        
        let edit = UITextField()
        edit.frame = CGRect.init(x: 40, y: 100, width: view.width-80, height: 64)
        edit.layer.borderWidth = 2
        edit.layer.cornerRadius = 5
        edit.text = "x = \\frac{-b \\pm \\sqrt{b^2-4ac}}{2a}"
        edit.delegate = self
        view.addSubview(edit)
        
        let line = UIView.init(frame: CGRect.init(x: 40, y: 180, width: view.width-80, height: 2))
        line.backgroundColor = UIColor.darkGray
        view.addSubview(line)
        
        //MARK: - editablemath
        showLabel.frame = CGRect.init(x: 40, y: 200, width: view.width-80, height: 64)
        view.addSubview(showLabel);
        
        let editLabel = MTEditableMathLabel()
        editLabel.frame = CGRect.init(x: 40, y: 300, width: view.width-80, height: editorHeight)
        editLabel.layer.borderWidth = 2
        editLabel.layer.cornerRadius = 5
        editLabel.backgroundColor = .white
        editLabel.delegate = self
        editLabel.keyboard = MTMathKeyboardRootView.sharedInstance()
        editLabel.enableTap(true)
        view.addSubview(editLabel)
    }
    
    //MARK: - delegate
    func textModified(_ label: MTEditableMathLabel!) {
        let minHeight:CGFloat = 64
        // Increase the height of the label as the height increases.
        let mathSize:CGSize = label.mathDisplaySize()
        if (mathSize.height > editorHeight - 10) {
            label.layoutIfNeeded()
            // animate
            UIView.animate(withDuration: 0.5) {
                self.editorHeight = mathSize.height + 10;
                label.height = self.editorHeight
                label.layoutIfNeeded()
            }
        } else if (mathSize.height < self.editorHeight - 20) {
            let newHeight:CGFloat = max(mathSize.height + 10, minHeight);
            if (newHeight < self.editorHeight) {
                label.layoutIfNeeded()
                // animate
                UIView.animate(withDuration: 0.5) {
                    self.editorHeight = newHeight;
                    label.height = self.editorHeight
                    label.layoutIfNeeded()
                }
            }
        }

        // Shrink the font as the label gets longer.
        if (mathSize.width > label.frame.size.width - 10) {
            label.fontSize = label.fontSize * 0.9;

        } else if (mathSize.width < label.frame.size.width - 40) {
            let fontSize:CGFloat = min(label.fontSize * 1.1, 30);
            if (fontSize > label.fontSize) {
                label.fontSize = fontSize;
            }
        }
        showLabel.text = label.mathList.stringValue
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        mtlabel.latex = textField.text
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
