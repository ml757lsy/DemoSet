//
//  AppStoreContentCell.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/12/6.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit

class AppStoreContentCell: UITableViewCell {
    
    private var _content:UIView = UIView()
    private var box:UIView = UIView()
    
    var content:UIView {
        get{
            return _content
        }
        set(newValue) {
            _content.removeFromSuperview()
            _content = newValue
            _content.frame = CGRect.init(x: 0, y: 0, width: SCREENWIDTH-40, height: 350)
            box.addSubview(_content)
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        baseinit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func baseinit() {
        box = UIView.init(frame: CGRect.init(x: 20, y: 0, width: SCREENWIDTH-40, height: 350))
        addSubview(box)
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        UIView.animate(withDuration: 0.2) {
            if highlighted {
                self.transform = CGAffineTransform.init(scaleX: 0.93, y: 0.93)
            }else{
                self.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            }
        }
        
    }

}
