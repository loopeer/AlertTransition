//
//  SnapKitAlertController.swift
//  AlertTransition
//
//  Created by 韩帅 on 2017/4/19.
//  Copyright © 2017年 Loopeer. All rights reserved.
//

import UIKit
import SnapKit

class SnapKitAlertController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let image = UIView(frame: CGRect.zero)
        image.backgroundColor = .randomColor
        
        let title = UIView(frame: CGRect.zero)
        title.backgroundColor = UIColor(red: 0.74, green: 0.74, blue: 0.74, alpha: 1)
        
        let content1 = UIView(frame: CGRect.zero)
        content1.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
        
        let content2 = UIView(frame: CGRect.zero)
        content2.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
        
        let content3 = UIView(frame: CGRect.zero)
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
        
        image.snp.makeConstraints { make in
            make.width.equalTo(200).priority(999)
            make.height.equalTo(150)
            make.left.top.right.equalToSuperview()
        }
        
        title.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(10)
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(image.snp.bottom).offset(15)
        }
        
        content1.snp.makeConstraints { make in
            make.width.equalTo(170)
            make.height.equalTo(10)
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(title.snp.bottom).offset(15)
        }
        
        content2.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(10)
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(content1.snp.bottom).offset(15)
        }
        
        content3.snp.makeConstraints { make in
            make.width.equalTo(170)
            make.height.equalTo(10)
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(content2.snp.bottom).offset(15)
            make.bottom.equalToSuperview().offset(-15).priority(999)
        }
    }
    
    func buttonClicked(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
