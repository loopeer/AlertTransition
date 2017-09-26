//
//  MenuPercentDrivenTransition.swift
//  AlertTransition
//
//  Created by 韩帅 on 2017/4/19.
//  Copyright © 2017年 Loopeer. All rights reserved.
//

import UIKit

class MenuPercentDrivenTransition: PercentDrivenInteractiveTransition {
    var transitionWidth: CGFloat = UIScreen.main.bounds.width
    
    override func setup(presentingView: UIView?) {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(presentPan(pan:)))
        pan.delegate = self
        presentingView?.addGestureRecognizer(pan)
        
        if let width = (transition?.toController as? AlertFrameProtocol)?.alertFrame.size.width {
            transitionWidth = width
        }
    }
    
    func setupDismissView(view: UIView) {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(dismissPan(pan:)))
        view.addGestureRecognizer(pan)
    }
    
    @objc func presentPan(pan: UIPanGestureRecognizer) {
        let offset = pan.translation(in: pan.view?.superview).x
        let persent = offset / transitionWidth
        
        switch pan.state {
        case .began:
            isTransiting = true
            
            if let owningController = transition?.toController {
                transition?.fromController?.present(owningController, animated: true, completion: nil)
            }
        case .changed:
            if persent >= 1 {
                update(0.999)
                return
            }
            update(persent)
        case .ended, .cancelled, .failed:
            isTransiting = false
            
            if persent > 0.5 {
                finish()
            } else {
                cancel()
            }
        default:
            break
        }
    }
    
    @objc func dismissPan(pan: UIPanGestureRecognizer) {
        let offset = -pan.translation(in: pan.view?.superview).x
        let persent = offset / transitionWidth
        
        switch pan.state {
        case .began:
            isTransiting = true
            transition?.fromController?.dismiss(animated: true, completion: nil)
        case .changed:
            if persent >= 1 {
                update(0.999)
                return
            }
            update(persent)
        case .ended, .cancelled, .failed:
            isTransiting = false
            
            if persent > 0.5 {
                finish()
            } else {
                cancel()
            }
        default:
            break
        }
    }
}

extension MenuPercentDrivenTransition: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let count = (transition?.fromController as? UINavigationController)?.childViewControllers.count, count == 1 else {
            return false
        }
        guard let view = transition?.fromController?.view else {
            return false
        }
        return gestureRecognizer.location(in: view).x < 40
    }
}
