//
//  StarWallTransition.swift
//  AlertTransition
//
//  Created by 韩帅 on 2017/4/19.
//  Copyright © 2017年 Loopeer. All rights reserved.
//

import UIKit
import AlertTransition

class StarWallTransition: AlertTransition {
    
    override func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return StarWarsGLAnimator()
    }
    
    
    override func performPresentedTransition(presentingView: UIView, presentedView: UIView, context: UIViewControllerContextTransitioning) {
        
        presentedView.alpha = 0
        
        UIView.animate(withDuration: duration, animations: { 
            presentedView.alpha = 1
        }) { complete in
            if context.transitionWasCancelled {
                context.completeTransition(false)
            } else {
                context.completeTransition(complete)
            }
        }
    }
}

