//
//  EasyStoryboardController.swift
//  AlertTransition
//
//  Created by 韩帅 on 2017/4/18.
//  Copyright © 2017年 Loopeer. All rights reserved.
//

import UIKit
import AlertTransition

class EasyStoryboardController: UITableViewController {
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination
        
        let transition = EasyTransition()
        transition.startTransforms = [.alpha(0), .rotation(angle: 0.75, anchorPoint: CGPoint(x: 0, y: 0)), .scale(0.5), .translation(x: 0, y: 200)]
        
        controller.at.transition = transition
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        guard indexPath.row != 3 else { return }
        
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let alert = storyBoard.instantiateViewController(withIdentifier: "StoryboardAlertController") as UIViewController
        let transition = EasyTransition()
        
        switch indexPath.row {
        case 0:
            transition.startTransforms = [.translation(x: 0, y: -100), .alpha(0)]
            transition.endTransforms = [.translation(x: 0, y: 100), .alpha(0)]
        case 1:
            transition.startTransforms = [.scale(0.5), .alpha(0)]
        case 2:
            transition.startTransforms = [.rotation(angle: 1.5, anchorPoint: CGPoint(x: 0, y: 0)), .alpha(0)]
        default:
            break
        }
        
        alert.at.transition = transition
        present(alert, animated: true, completion: nil)
    }
}
