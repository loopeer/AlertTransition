//
//  MenuTransition.swift
//  AlertTransition
//
//  Created by 韩帅 on 2017/4/19.
//  Copyright © 2017年 Loopeer. All rights reserved.
//

import UIKit

public class MenuTransition: AlertTransition {

    var maskView: UIView?
    
    public override init(from controller: UIViewController?) {
        super.init(from: controller)
        interactionTransitionType = MenuPercentDrivenTransition.self
    }
    
    public override func performPresentedTransition(presentingView: UIView, presentedView: UIView, context: UIViewControllerContextTransitioning) {
        
        if maskView == nil {
            UIGraphicsBeginImageContextWithOptions(UIScreen.main.bounds.size, true, UIScreen.main.scale)
            presentingView.layer.render(in: UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            maskView = UIView(frame: presentingView.bounds)
            maskView?.layer.contents = image?.cgImage
            
            if let percentDrivenTransition = interactionTransition as? MenuPercentDrivenTransition {
                percentDrivenTransition.setupDismissView(view: maskView!)
            }
        }
        context.containerView.addSubview(maskView!)
        
        presentedView.frame.origin.x = -presentedView.frame.width / 2
        
        UIView.animate(withDuration: duration, delay: 0, options: [.curveLinear], animations: {
            presentedView.transform = CGAffineTransform(translationX: presentedView.frame.width / 2, y: 0)
            self.maskView?.transform = CGAffineTransform(translationX: presentedView.frame.width, y: 0)
        }) { (complete) in
            if context.transitionWasCancelled {
                context.completeTransition(false)
            }else{
                context.completeTransition(complete)
            }
        }
    }
    
    public override func performDismissedTransition(presentingView: UIView, presentedView: UIView, context: UIViewControllerContextTransitioning) {
        
        UIView.animate(withDuration: duration, delay: 0, options: [.curveLinear], animations: {
            presentedView.transform = CGAffineTransform.identity
            self.maskView?.transform = CGAffineTransform.identity
        }) { (complete) in
            if context.transitionWasCancelled {
                context.completeTransition(false)
            }else{
                context.completeTransition(complete)
            }
        }
    }
}
