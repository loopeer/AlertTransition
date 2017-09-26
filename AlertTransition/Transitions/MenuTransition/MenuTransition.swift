//
//  MenuTransition.swift
//  AlertTransition
//
//  Created by 韩帅 on 2017/4/19.
//  Copyright © 2017年 Loopeer. All rights reserved.
//

import UIKit

public class MenuTransition: AlertTransition {

    public internal(set) var forgroundMask: UIView?
    
    public override init(from controller: UIViewController?) {
        super.init(from: controller)
        interactionTransitionType = MenuPercentDrivenTransition.self
    }
    
    public override func performPresentedTransition(presentingView: UIView, presentedView: UIView, context: UIViewControllerContextTransitioning) {
        
        if forgroundMask == nil {
            
            forgroundMask = UIView(frame: presentingView.bounds)
            
            if let percentDrivenTransition = interactionTransition as? MenuPercentDrivenTransition {
                percentDrivenTransition.setupDismissView(view: forgroundMask!)
            }
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(maskTapped(tap:)))
            forgroundMask?.addGestureRecognizer(tap)
        }
        
        UIGraphicsBeginImageContextWithOptions(UIScreen.main.bounds.size, true, UIScreen.main.scale)
        presentingView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        forgroundMask?.layer.contents = image?.cgImage
        
        context.containerView.addSubview(forgroundMask!)
        presentedView.frame.origin.x = -presentedView.frame.width / 2
        
        UIView.animate(withDuration: duration, delay: 0, options: [.curveLinear], animations: {
            presentedView.transform = CGAffineTransform(translationX: presentedView.frame.width / 2, y: 0)
            self.forgroundMask?.transform = CGAffineTransform(translationX: presentedView.frame.width, y: 0)
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
            self.forgroundMask?.transform = CGAffineTransform.identity
        }) { (complete) in
            if context.transitionWasCancelled {
                context.completeTransition(false)
            }else{
                context.completeTransition(complete)
            }
        }
    }
    
    @objc func maskTapped(tap: UITapGestureRecognizer) {
        guard shouldDismissOutside else { return }
        
        fromController?.dismiss(animated: true, completion: nil)
    }
}
