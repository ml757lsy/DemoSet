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
class LaTeXViewController: BaseViewController,MTEditableMathLabelDelegate {

    var editorHeight:CGFloat = 64;
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initView()
    }
    
    func initView() {
        let label = MTMathUILabel()
        label.labelMode = .text
        label.textAlignment = .left
        label.fontSize = 25
        label.latex = "x = \\frac{-b \\pm \\sqrt{b^2-4ac}}{2a}"
        label.sizeToFit()
        view.addSubview(label)
        
        //edit
        let editLabel = MTEditableMathLabel()
        editLabel.frame = CGRect.init(x: 40, y: 100, width: 200, height: editorHeight)
        editLabel.layer.borderWidth = 2
        editLabel.layer.cornerRadius = 5
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
                label.layoutIfNeeded()
            }
        } else if (mathSize.height < self.editorHeight - 20) {
            let newHeight:CGFloat = max(mathSize.height + 10, minHeight);
            if (newHeight < self.editorHeight) {
                label.layoutIfNeeded()
                // animate
                UIView.animate(withDuration: 0.5) {
                    self.editorHeight = newHeight;
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
