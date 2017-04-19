//
//  TrolleyController.swift
//  AlertTransition
//
//  Created by 韩帅 on 2017/4/19.
//  Copyright © 2017年 Loopeer. All rights reserved.
//

import UIKit
import AlertTransition

class TrolleyController: UIViewController, AlertFrameProtocol {
    
    var alertFrame: CGRect {
        let height = UIScreen.main.bounds.width / 638 * 893
        return CGRect(x: 0, y: UIScreen.main.bounds.height - height, width: UIScreen.main.bounds.width, height: height)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer.contents = #imageLiteral(resourceName: "trolley_background").cgImage
    }
}
