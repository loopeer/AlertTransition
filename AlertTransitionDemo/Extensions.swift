//
//  Extensions.swift
//  AlertTransition
//
//  Created by 韩帅 on 2017/4/18.
//  Copyright © 2017年 Loopeer. All rights reserved.
//

import UIKit

extension UIColor {
    static var randomColor: UIColor {
        func randomFloat() -> CGFloat {
            return CGFloat(Double(arc4random()) / 0x100000000)
        }
        
        return UIColor(red: randomFloat(), green: randomFloat(), blue: randomFloat(), alpha: 1)
    }
}
