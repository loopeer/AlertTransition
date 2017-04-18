//
//  StoryboardAlertController.swift
//  AlertTransition
//
//  Created by 韩帅 on 2017/4/18.
//  Copyright © 2017年 Loopeer. All rights reserved.
//

import UIKit

class StoryboardAlertController: UIViewController {

    @IBOutlet weak var imageView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.backgroundColor = .randomColor
    }
    
    @IBAction func dismiss() {
        dismiss(animated: true, completion: nil)
    }
}
