//
//  TrolleyTransition.swift
//  AlertTransition
//
//  Created by 韩帅 on 2017/4/19.
//  Copyright © 2017年 Loopeer. All rights reserved.
//

import UIKit

public class TrolleyTransition: AlertTransition {

    public override init(from controller: UIViewController?) {
        super.init(from: controller)
        duration = 0.5
    }
    
    public override func performPresentedTransition(presentingView: UIView, presentedView: UIView, context: UIViewControllerContextTransitioning) {
        presentedView.frame.origin.y = UIScreen.main.bounds.height
        
        UIView.animate(withDuration: duration/2, animations: {
            presentingView.layer.transform = self.firstTransform()
        }) { (complete) in
            UIView.animate(withDuration: self.duration/2, animations: {
                presentingView.layer.transform = self.secondTransform()
                presentedView.transform = CGAffineTransform(translationX: 0, y: -presentedView.frame.height)
            }, completion: { (complete) in
                context.completeTransition(complete)
            })
        }
    }
    
    public override func performDismissedTransition(presentingView: UIView, presentedView: UIView, context: UIViewControllerContextTransitioning) {
        
        UIView.animate(withDuration: duration/2, animations: {
            presentedView.transform = CGAffineTransform.identity
            presentingView.layer.transform = self.firstTransform()
        }) { (complete) in
            UIView.animate(withDuration: self.duration/2, animations: {
                presentingView.layer.transform = CATransform3DIdentity
            }, completion: { (complete) in
                context.completeTransition(complete)
            })
        }
    }
    
    private func firstTransform() -> CATransform3D {
        var form = CATransform3DIdentity
        form.m34 = 1.0 / -900
        form = CATransform3DScale(form, 0.9, 0.9, 1)
        form = CATransform3DRotate(form, 15.0 * CGFloat(Double.pi)/180.0, 1, 0, 0)
        form = CATransform3DTranslate(form, 0, 0, -100.0)
        return form
    }
    
    private func secondTransform() -> CATransform3D {
        var form = CATransform3DIdentity
        form.m34 = firstTransform().m34
        form = CATransform3DTranslate(form, 0, -20, 0)
        form = CATransform3DScale(form, 0.9, 0.9, 1)
        return form
    }
}
