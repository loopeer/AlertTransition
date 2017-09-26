//
//  EasyPercentDrivenTransition.swift
//  AlertTransition
//
//  Created by 韩帅 on 2017/4/18.
//  Copyright © 2017年 Loopeer. All rights reserved.
//

import UIKit

class EasyPercentDrivenTransition: PercentDrivenInteractiveTransition {
    
    var originFrame = CGRect.zero
    var presentedView: UIView?
    
    public override func setup(presentedView: UIView) {
        self.presentedView = presentedView
        
        let closeGesture = (transition as? EasyTransition)?.closeGesture ?? false
        if !closeGesture {
            let pan = UIPanGestureRecognizer(target: self, action: #selector(dismiss(pan:)))
            presentedView.addGestureRecognizer(pan)
            originFrame = presentedView.frame
        }
    }
    
    override func deviceOrientationChanged() {
        originFrame = presentedView?.frame ?? CGRect.zero
    }
    
    @objc func dismiss(pan: UIPanGestureRecognizer) {
        let point = pan.translation(in: pan.view?.superview)
        
        switch pan.state {
            
        case .changed:
            pan.view?.frame.origin.x = originFrame.minX + point.x
            pan.view?.frame.origin.y = originFrame.minY + point.y
        case .ended, .cancelled, .failed:
            
            guard fabs(Double(point.x)) <= 70 && fabs(Double(point.y)) <= 70 else {
                transition?.toController?.dismiss(animated: true, completion: nil)
                return
            }
            
            pan.view?.isUserInteractionEnabled = false
            UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                pan.view?.frame = self.originFrame
            }) { (complete) in
                pan.view?.isUserInteractionEnabled = true
            }
        default:
            break
        }
    }
}
