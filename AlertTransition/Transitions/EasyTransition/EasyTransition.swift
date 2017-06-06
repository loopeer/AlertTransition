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
        case translation(x: CGFloat, y: CGFloat)
        case rotation(angle: CGFloat, anchorPoint: CGPoint)
        case scale(CGFloat)
        case alpha(CGFloat)
        
        func apply(to view: UIView) {
            
            switch self {
            case .translation(let x, let y):
                view.transform = view.transform.concatenating(CGAffineTransform(translationX: x, y: y))
            case .rotation(let angle, let anchorPoint):
                let originOffset = CGPoint(x: anchorPoint.x - view.layer.anchorPoint.x, y: anchorPoint.y - view.layer.anchorPoint.y)
                let positionOffset = CGPoint(x: originOffset.x * view.layer.frame.width, y: originOffset.y * view.layer.frame.height)
                
                view.layer.anchorPoint = anchorPoint
                view.layer.position = CGPoint(x: view.layer.position.x + positionOffset.x, y: view.layer.position.y + positionOffset.y)
                view.transform = view.transform.concatenating(CGAffineTransform(rotationAngle: angle))
            case .scale(let scale):
                view.transform = view.transform.concatenating(CGAffineTransform(scaleX: scale, y: scale))
            case .alpha(let alpha):
                view.alpha = alpha
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
    public var startTransforms: [AnimationType] = [.alpha(0), .translation(x: 0, y: 200)]
    /// Set the end state of Alert
    public var endTransforms: [AnimationType]?
    /// Set the state of view in presentatingController
    public var presentatingViewTransforms: [AnimationType]?
    /// Set the spring animation params in present, include duration、damping、velocity、UIViewAnimationOptions
    public var presentAnimateParams = AnimateParams()
    /// Set the spring animation params in dismiss
    public var dismissAnimateParams = AnimateParams()
    
    public var closeGesture = false

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
    
    public override init(from controller: UIViewController? = nil) {
        super.init(from: controller)
        
        interactionTransitionType = EasyPercentDrivenTransition.self
    }
    
    public override func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        if transitionState == .presented {
            return presentAnimateParams.duration
        } else {
            return dismissAnimateParams.duration
        }
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
        transforms.forEach { $0.apply(to: view) }
    }
}
