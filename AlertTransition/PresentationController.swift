//
//  LPPresentationController.swift
//  AlertTransition
//
//  Created by 韩帅 on 2017/4/17.
//  Copyright © 2017年 Loopeer. All rights reserved.
//

import UIKit

open class PresentationController: UIPresentationController {
    
    /// The transition used in
    public internal(set) weak var transition: AlertTransition?
    
    /// The background view, initialized when presentationTransitionWillBegin, inserted to view hierarchy when containerViewWillLayoutSubviews
    public fileprivate(set) var maskView: UIView?
    
    private var deviceOrientation = UIDeviceOrientation.portrait
    
    open override var frameOfPresentedViewInContainerView: CGRect {
        if let frame = (presentedViewController as? AlertFrameProtocol)?.alertFrame {
            return frame
        }
        
        let size = presentedViewController.view.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        // the controller view using SnapKit constraints, leading to translatesAutoresizingMaskIntoConstraints = false
        presentedViewController.view.translatesAutoresizingMaskIntoConstraints = true
        
        return CGRect(origin: CGPoint(x: (UIScreen.main.bounds.size.width - size.width)*0.5, y: (UIScreen.main.bounds.size.height - size.height)*0.5), size: size)
    }
    
    override open func presentationTransitionWillBegin() {
        containerView?.addSubview(presentedView!)
        if maskView == nil {
            maskView = makeMaskView()
        }
        deviceOrientation = UIDevice.current.orientation
    }
    
    override open func containerViewWillLayoutSubviews() {
        if let view = maskView, view.superview == nil {
            containerView?.insertSubview(view, at: 0)
        }
        
        guard deviceOrientation != UIDevice.current.orientation else { return }
        
        deviceOrientation = UIDevice.current.orientation
        /// Change Device Orientation
        maskView?.frame = UIScreen.main.bounds
        presentedView?.frame = frameOfPresentedViewInContainerView
        transition?.interactionTransition?.deviceOrientationChanged()
    }
    
    /// Override this method to make custom MaskView
    open func makeMaskView() -> UIView {
        var mask: UIView
        
        switch transition!.backgroundType {
        case .color(let color):
            
            mask = UIView()
            mask.backgroundColor = color
        case .blurEffect(let style, let alpha):
            
            mask = UIVisualEffectView(effect: UIBlurEffect(style: style))
            mask.alpha = alpha
        }
        
        mask.frame = UIScreen.main.bounds
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(close))
        mask.addGestureRecognizer(tap)
        
        return mask
    }
    
    @objc public func close() {
        guard transition?.shouldDismissOutside ?? true else {
            return
        }
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}
