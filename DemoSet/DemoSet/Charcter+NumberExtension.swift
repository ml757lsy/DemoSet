//
//  Charcter+NumberExtension.swift
//  DemoSet
//
//  Created by 李世远 on 2019/1/24.
//  Copyright © 2019 Far. All rights reserved.
//

import UIKit

extension Character {
    
    var int:Int {
        return Int(String(self)) ?? 0
    }
    
}
