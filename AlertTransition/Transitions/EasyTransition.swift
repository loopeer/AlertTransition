//
//  EasyTransition.swift
//  AlertTransition
//
//  Created by 韩帅 on 2017/4/18.
//  Copyright © 2017年 Loopeer. All rights reserved.
//

import UIKit


public extension EasyTransition {
    enum AnimationType {
        case transition(x: CGFloat, y: CGFloat)
        case rotation(angle: CGFloat)
        case scale(CGFloat)
        case alpha(CGFloat)
        
        var transform: CGAffineTransform {
            switch self {
            case .transition(let x, let y):
                return CGAffineTransform(translationX: x, y: y)
            case .rotation(let angle):
                return CGAffineTransform(rotationAngle: angle)
            case .scale(let scale):
                return CGAffineTransform(scaleX: scale, y: scale)
            default:
                return CGAffineTransform.identity
            }
        }
    }
    
    struct AnimateParams {
        public var duration: TimeInterval = 0.25
        public var damping: CGFloat = 0.7
        public var velocity: CGFloat = 0
        public var options: UIViewAnimationOptions = .curveEaseInOut
    }
}


public class EasyTransition: AlertTransition {
    /// Set the start state of Alert
    public var startTransforms: [AnimationType] = [.alpha(0), .transition(x: 0, y: 200)]
    /// Set the end state of Alert
    public var endTransforms: [AnimationType]?
    /// Set the state of view in presentatingController
    public var presentatingViewTransforms: [AnimationType]?
    /// Set the spring animation params in present, include duration、damping、velocity、UIViewAnimationOptions
    public var presentAnimateParams = AnimateParams()
    /// Set the spring animation params in dismiss
    public var dismissAnimateParams = AnimateParams()

    public var disableGestureDismiss = false {
        didSet {
            guard disableGestureDismiss == true else { return }
            
            interactionTransition = nil
        }
    }
    
    public override var duration: TimeInterval {
        didSet {
            presentAnimateParams.duration = duration
            dismissAnimateParams.duration = duration
        }
    }
    
    public override init(fromController: UIViewController? = nil) {
        super.init(fromController: fromController)
        
        interactionTransitionType = EasyPercentDrivenTransition.self
    }
    
    public override func performPresentedTransition(presentingView originalView: UIView, presentedView: UIView,context: UIViewControllerContextTransitioning) {
        
        apply(transforms: startTransforms, to: presentedView)
        
        UIView.animate(withDuration: presentAnimateParams.duration, delay: 0, usingSpringWithDamping: presentAnimateParams.damping, initialSpringVelocity: presentAnimateParams.velocity, options: presentAnimateParams.options, animations: {
            presentedView.transform = CGAffineTransform.identity
            presentedView.alpha = 1
            if let originalViewTransforms = self.presentatingViewTransforms {
                self.apply(transforms: originalViewTransforms, to: originalView)
            }
        }) { (complete) in
            if context.transitionWasCancelled {
                context.completeTransition(false)
            } else {
                context.completeTransition(complete)
            }
        }
    }
    
    public override func performDismissedTransition(presentingView originalView: UIView, presentedView: UIView,context: UIViewControllerContextTransitioning) {
        
        UIView.animate(withDuration: dismissAnimateParams.duration, delay: 0, usingSpringWithDamping: dismissAnimateParams.damping, initialSpringVelocity: dismissAnimateParams.velocity, options: dismissAnimateParams.options, animations: {
            self.apply(transforms: self.endTransforms ?? self.startTransforms, to: presentedView)
            originalView.transform = CGAffineTransform.identity
        }) { (complete) in
            if context.transitionWasCancelled {
                context.completeTransition(false)
            } else {
                context.completeTransition(complete)
            }
        }
    }
    
    func apply(transforms: [AnimationType], to view: UIView) {
        let transform = transforms.reduce(CGAffineTransform.identity) { $0.concatenating($1.transform) }
        
        view.transform = transform
        
        transforms.forEach {
            guard case let AnimationType.alpha(alpha) = $0 else {
                return
            }
            
            view.alpha = alpha
        }
    }
}
