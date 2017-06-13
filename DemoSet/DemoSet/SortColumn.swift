//
//  SortColumn.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/6/13.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit

enum SortState:Int {
    case normal = 0
    case choose = 1
    case aim    = 2
}

class SortColumn: UIView {
    
    private var state:SortState = .normal
    private var value:Int = 0
    

    var sortState:SortState {
        get {
            return state
        }
        set(newValue) {
            state = newValue
            updateView()
        }
    }
    
    var sortValue:Int {
        get {
            return value
        }
        set(newValue) {
            value = newValue
            updateView()
        }
    }
    
    func updateView() {
        //
        switch state {
        case .normal:
            //
            self.backgroundColor = UIColor.lightGray
            break
        case .choose:
            //
            self.backgroundColor = UIColor.blue
            break
        case .aim:
            //
            self.backgroundColor = UIColor.red
            break
        default:
            //
            break
        }
        
        //
        self.height = CGFloat(sortValue)*20.0
        
    }

}
