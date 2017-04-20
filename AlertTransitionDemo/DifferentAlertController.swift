//
//  DifferentAlertController.swift
//  AlertTransition
//
//  Created by 韩帅 on 2017/4/19.
//  Copyright © 2017年 Loopeer. All rights reserved.
//

import UIKit
import AlertTransition

class DifferentAlertController: UITableViewController {
    
    var titles = ["Alert (AlertFrameProtocol)", "Alert (constraints, storyboard)", "Alert (constraints, SnapKit)"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "AlertTransition"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.description())
        tableView.tableFooterView = UIView()
    }
}

extension DifferentAlertController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.description(), for: indexPath)
        cell.textLabel?.text = titles[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        
        let alert: UIViewController
        
        switch indexPath.row {
        case 0:
            alert = NormalAlertController()
        case 1:
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            alert = storyBoard.instantiateViewController(withIdentifier: "StoryboardAlertController") as UIViewController
        default:
            alert = SnapKitAlertController()
        }
        
        let transition = EasyTransition()
        transition.startTransforms = [.alpha(0), .rotation(angle: 0.75, anchorPoint: CGPoint(x: 0, y: 0)), .scale(0.5), .translation(x: 0, y: 200)]
        alert.at.transition = transition
        
        present(alert, animated: true, completion: nil)
    }
}
