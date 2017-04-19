//
//  NormalAlertController.swift
//  AlertTransition
//
//  Created by 韩帅 on 2017/4/18.
//  Copyright © 2017年 Loopeer. All rights reserved.
//

import UIKit
import AlertTransition

class NormalAlertController: UIViewController, AlertFrameProtocol {
    
    var alertFrame: CGRect {
        let x = (UIScreen.main.bounds.size.width - 200) / 2
        let y = (UIScreen.main.bounds.size.height - 250) / 2
        return CGRect(x: x, y: y, width: 200, height: 250)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let image = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 150))
        image.backgroundColor = .randomColor
        
        let title = UIView(frame: CGRect(x: 15, y: image.frame.maxY + 15, width: 100, height: 10))
        title.backgroundColor = UIColor(red: 0.74, green: 0.74, blue: 0.74, alpha: 1)
        
        let content1 = UIView(frame: CGRect(x: 15, y: title.frame.maxY + 10, width: 170, height: 10))
        content1.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
        
        let content2 = UIView(frame: CGRect(x: 15, y: content1.frame.maxY + 10, width: 150, height: 10))
        content2.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
        
        let content3 = UIView(frame: CGRect(x: 15, y: content2.frame.maxY + 10, width: 170, height: 10))
        content3.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
        
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "alert_dismiss"), for: .normal)
        button.addTarget(self, action: #selector(buttonClicked(sender:)), for: .touchUpInside)
        button.sizeToFit()
        button.frame.origin = CGPoint(x: 155, y: 10)
        
        view.addSubview(image)
        view.addSubview(title)
        view.addSubview(content1)
        view.addSubview(content2)
        view.addSubview(content3)
        view.addSubview(button)
    }
    
    func buttonClicked(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    deinit {
        print("---deinit---")
    }
}
