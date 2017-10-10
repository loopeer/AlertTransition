//
//  TrolleyTransition.swift
//  AlertTransition
//
//  Created by 韩帅 on 2017/4/19.
//  Copyright © 2017年 Loopeer. All rights reserved.
//

import UIKit

public class TrolleyTransition: AlertTransition {
    
    public var m34: CGFloat = 1.0 / -6000
    public var scale: CGFloat = 0.85
    public var rotate: CGFloat = 15.0 * CGFloat(Double.pi)/180.0
    public var zTranslate: CGFloat = -100.0

    public override init(from controller: UIViewController?) {
        super.init(from: controller)
        duration = 0.5
    }
    
    public override func performPresentedTransition(presentingView: UIView, presentedView: UIView, context: UIViewControllerContextTransitioning) {
        presentedView.frame.origin.y = UIScreen.main.bounds.height
       
        UIView.animate(withDuration: duration, animations: {
            presentedView.transform = CGAffineTransform(translationX: 0, y: -presentedView.frame.height)
        })
            
        UIView.animate(withDuration: duration/2, animations: {
            presentingView.layer.transform = self.firstTransform()
        }) { (complete) in
            UIView.animate(withDuration: self.duration/2, animations: {
                presentingView.layer.transform = self.secondTransform()
            }, completion: { (complete) in
                context.completeTransition(complete)
            })
        }
    }
    
    public override func performDismissedTransition(presentingView: UIView, presentedView: UIView, context: UIViewControllerContextTransitioning) {
        
        UIView.animate(withDuration: duration, animations: {
            presentedView.transform = CGAffineTransform.identity
        })
        
        UIView.animate(withDuration: duration/2, animations: {
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
        form.m34 = m34
        form = CATransform3DScale(form, scale, scale, 1)
        form = CATransform3DRotate(form, rotate, 1, 0, 0)
        form = CATransform3DTranslate(form, 0, 0, zTranslate)
        return form
    }
    
    private func secondTransform() -> CATransform3D {
        var form = CATransform3DIdentity
        form.m34 = firstTransform().m34
        form = CATransform3DTranslate(form, 0, -20, 0)
        form = CATransform3DScale(form, scale, scale, 1)
        return form
    }
}
