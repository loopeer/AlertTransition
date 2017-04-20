//
//  BackgroundTypeController.swift
//  AlertTransition
//
//  Created by 韩帅 on 2017/4/19.
//  Copyright © 2017年 Loopeer. All rights reserved.
//

import UIKit
import AlertTransition


class BackgroundTypeController: UITableViewController {
    
    var titles = ["blur-extraLight + alpha", "blur-light + alpha", "blur-dark + alpha", "custom color + alpha"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "BackgroundType"
        view.layer.contents = #imageLiteral(resourceName: "backgroud_image").cgImage
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.description())
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .clear
    }
}

extension BackgroundTypeController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.description(), for: indexPath)
        cell.backgroundColor = .clear
        cell.textLabel?.backgroundColor = .clear
        cell.textLabel?.text = titles[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        
        let alert = NormalAlertController()
        
        let transition = EasyTransition()
        transition.startTransforms = [.alpha(0), .rotation(angle: 0.75, anchorPoint: CGPoint(x: 0, y: 0)), .scale(0.5), .translation(x: 0, y: 200)]
        
        switch indexPath.row {
        case 0:
            transition.backgroundType = .blurEffect(style: .extraLight, alpha: 0.9)
        case 1:
            transition.backgroundType = .blurEffect(style: .light, alpha: 0.9)
        case 2:
            transition.backgroundType = .blurEffect(style: .dark, alpha: 0.9)
        case 3:
            transition.backgroundType = .color(UIColor.blue.withAlphaComponent(0.5))
        default:
            break
        }
        
        alert.at.transition = transition
        
        present(alert, animated: true, completion: nil)
    }
}
