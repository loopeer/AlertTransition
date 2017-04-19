//
//  BubbleController.swift
//  AlertTransition
//
//  Created by 韩帅 on 2017/4/19.
//  Copyright © 2017年 Loopeer. All rights reserved.
//

import UIKit
import AlertTransition

class BubbleController: UIViewController, AlertFrameProtocol {
    
    var alertFrame: CGRect { return UIScreen.main.bounds }
    
    var label: UILabel!
    var dismissButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        label = UILabel()
        label.text = "Hello!"
        label.font = UIFont.systemFont(ofSize: 50)
        label.textColor = .white
        label.sizeToFit()
        label.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: 100)
        
        dismissButton = UIButton(type: .custom)
        dismissButton.backgroundColor = UIColor.white
        dismissButton.setImage(#imageLiteral(resourceName: "dismiss_button"), for: .normal)
        dismissButton.bounds = CGRect(x: 0, y: 0, width: 60, height: 60)
        dismissButton.layer.cornerRadius = 30
        dismissButton.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height - 50)
        dismissButton.addTarget(self, action: #selector(buttonClicked(sender:)), for: .touchUpInside)
        
        view.addSubview(label)
        view.addSubview(dismissButton)
    }
    
    func buttonClicked(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
