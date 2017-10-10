//
//  MenuTransition.swift
//  AlertTransition
//
//  Created by 韩帅 on 2017/4/19.
//  Copyright © 2017年 Loopeer. All rights reserved.
//

import UIKit

public class MenuTransition: AlertTransition {

    public internal(set) var originSuperView: UIView?
    
    public override init(from controller: UIViewController?) {
        super.init(from: controller)
        interactionTransitionType = MenuPercentDrivenTransition.self
        backgroundType = .color(.clear)
    }
    
    public override func performPresentedTransition(presentingView: UIView, presentedView: UIView, context: UIViewControllerContextTransitioning) {
        presentationController?.manualMaskAnimation = true
        originSuperView = presentingView.superview
        context.containerView.addSubview(presentingView)
        context.containerView.addSubview(maskView!)
        (interactionTransition as? MenuPercentDrivenTransition)?.setupDismissView(view: maskView!)
        
        presentedView.frame.origin.x = -presentedView.frame.width / 2
        presentingView.frame.origin.x = 0
        maskView?.frame = presentingView.frame
        
        // HACK: If zero, the animation briefly flashes in iOS 11. UIViewPropertyAnimators (iOS 10+) may resolve this.
        let delay = (interactionTransition?.isTransiting ?? false) ? duration : 0
        
        UIView.animate(withDuration: duration, delay: delay, options: [.curveLinear], animations: {
            presentedView.transform = CGAffineTransform(translationX: presentedView.frame.width / 2, y: 0)
            presentingView.frame.origin.x = presentedView.frame.width
            self.maskView?.frame = presentingView.frame
            self.presentationController?.showMaskView()
        }) { (complete) in
            if context.transitionWasCancelled {
                context.completeTransition(false)
                self.originSuperView?.addSubview(presentingView)
            }else{
                context.completeTransition(complete)
            }
        }
    }
    
    public override func performDismissedTransition(presentingView: UIView, presentedView: UIView, context: UIViewControllerContextTransitioning) {
        
        // HACK: If zero, the animation briefly flashes in iOS 11. UIViewPropertyAnimators (iOS 10+) may resolve this.
        let delay = (interactionTransition?.isTransiting ?? false) ? duration : 0
        
        UIView.animate(withDuration: duration, delay: delay, options: [.curveLinear], animations: {
            self.dismissActions()
        }) { (complete) in
            if context.transitionWasCancelled {
                context.completeTransition(false)
            }else{
                context.completeTransition(complete)
                self.originSuperView?.addSubview(presentingView)
            }
        }
    }
    
    public func dismissActions() {
        toController.view.transform = CGAffineTransform.identity
        fromController?.view.frame.origin.x = 0
        self.maskView?.frame = fromController?.view.frame ?? CGRect.zero
        self.presentationController?.hideMaskView()
    }
    
    public func push(controller: UIViewController, from navi: UINavigationController? = nil) {
        guard let naviController = navi ?? (fromController as? UINavigationController) else { return }
        
        CATransaction.begin()
        CATransaction.setCompletionBlock( { () -> Void in
            self.toController.dismiss(animated: true, completion: nil)
        })
        UIView.animate(withDuration: duration, animations: { () -> Void in
            self.dismissActions()
        })
        naviController.pushViewController(controller, animated: true)
        CATransaction.commit()
    }
}
