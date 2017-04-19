//
//  MenuController.swift
//  AlertTransition
//
//  Created by 韩帅 on 2017/4/19.
//  Copyright © 2017年 Loopeer. All rights reserved.
//

import UIKit
import AlertTransition

class MenuController: UIViewController, AlertFrameProtocol {
    
    var alertFrame: CGRect {
        let width = UIScreen.main.bounds.size.height / 1136 * 511
        return CGRect(x: 0, y: 0, width: width, height: UIScreen.main.bounds.size.height)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer.contents = #imageLiteral(resourceName: "menu_background").cgImage
    }
}
