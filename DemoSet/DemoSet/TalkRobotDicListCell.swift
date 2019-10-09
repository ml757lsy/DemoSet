//
//  TalkRobotDicListCell.swift
//  DemoSet
//
//  Created by lishiyuan on 2019/9/4.
//  Copyright © 2019 Far. All rights reserved.
//

import UIKit

class TalkRobotDicListCell: UITableViewCell {
    
    var keysLabel = UILabel.init()
    let answersLabel = UILabel.init()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        baseInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func baseInit() {
//        self.backgroundColor = UIColor.red
        keysLabel.frame = CGRect.init(x: 20, y: 0, width: SCREENWIDTH, height: 20)
        addSubview(keysLabel)
        
        answersLabel.frame = CGRect.init(x: 20, y: 20, width: SCREENWIDTH, height: 40)
        addSubview(answersLabel)
    }
    
    func setKeys(keys:[String],and answers:[String]) {
        let att = NSMutableAttributedString.init()
        for k in keys {
            let ak = NSAttributedString.init(string: k, attributes: [NSAttributedString.Key.foregroundColor:UIColor.randomColor()])
            att.append(ak)
            att.append(NSAttributedString.init(string: "    ", attributes: [:]))
        }
        keysLabel.attributedText = att
        
        let ast = NSMutableAttributedString.init()
        for a in answers {
            let p = NSAttributedString.init(string: "◎", attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
            let at = NSAttributedString.init(string: a, attributes: [NSAttributedString.Key.foregroundColor:UIColor.randomColor()])
            ast.append(p)
            ast.append(at)
            ast.append(NSMutableAttributedString.init(string: "\n", attributes: [:]))
        }
        answersLabel.attributedText = ast
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
