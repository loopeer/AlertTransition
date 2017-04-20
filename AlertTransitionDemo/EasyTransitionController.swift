//
//  EasyTransitionController.swift
//  AlertTransition
//
//  Created by 韩帅 on 2017/4/18.
//  Copyright © 2017年 Loopeer. All rights reserved.
//

import UIKit
import AlertTransition

class EasyTransitionController: UITableViewController {
    
    let titles = ["transition", "rotation", "scale", "alpha", "transition + alpha", "scale + alpha", "rotation + alpha", "transition + rotation", "transition + rotation + scale + alpha", "presentatingViewTransforms", "presentAnimateParams"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "EasyTransition"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.description())
        tableView.tableFooterView = UIView()
    }
}

extension EasyTransitionController {
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
        
        let alert = NormalAlertController()
        let transition = EasyTransition()
        
        switch indexPath.row {
        case 0:
            transition.startTransforms = [.translation(x: 0, y: 500)]
        case 1:
            transition.startTransforms = [.rotation(angle: CGFloat(Double.pi/2), anchorPoint: CGPoint(x: 0, y: 0))]
        case 2:
            transition.startTransforms = [.scale(0.1)]
        case 3:
            transition.startTransforms = [.alpha(0)]
        case 4:
            transition.startTransforms = [.translation(x: 0, y: -100), .alpha(0)]
            transition.endTransforms = [.translation(x: 0, y: 100), .alpha(0)]
        case 5:
            transition.startTransforms = [.scale(0.5), .alpha(0)]
        case 6:
            transition.startTransforms = [.rotation(angle: CGFloat(Double.pi/2), anchorPoint: CGPoint(x: 0, y: 0)), .alpha(0)]
        case 7:
            transition.startTransforms = [.rotation(angle: -0.75, anchorPoint: CGPoint(x: 0, y: 0)), .translation(x: 0, y: -300)]
            transition.endTransforms = [.scale(0.5), .alpha(0)]
        case 8:
            transition.startTransforms = [.alpha(0), .rotation(angle: 0.75, anchorPoint: CGPoint(x: 0, y: 0)), .scale(0.5), .translation(x: 0, y: 200)]
        case 9:
            transition.startTransforms = [.scale(0.5), .alpha(0)]
            transition.presentatingViewTransforms = [.scale(0.9)]
        case 10:
            transition.startTransforms = [.translation(x: 0, y: 500)]
            transition.presentAnimateParams.damping = 0.3
        default:
            break
        }
        
        alert.at.transition = transition
        present(alert, animated: true, completion: nil)
    }
}
