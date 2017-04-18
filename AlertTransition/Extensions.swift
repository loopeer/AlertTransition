//
//  Extensions.swift
//  AlertTransition
//
//  Created by 韩帅 on 2017/4/17.
//  Copyright © 2017年 Loopeer. All rights reserved.
//

import UIKit

public final class AlertExtension<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

/**
 A type that has AlertTransition extensions.
 */
public protocol ExtensionCompatible {
    associatedtype CompatibleType
    var at: CompatibleType { get }
}

public extension ExtensionCompatible {
    public var at: AlertExtension<Self> {
        get { return AlertExtension(self) }
    }
}

extension UIViewController: ExtensionCompatible { }


private var transitionKey: Void?

extension AlertExtension where Base: UIViewController {
    
    public var transition: AlertTransition? {
        get {
            return objc_getAssociatedObject(base, &transitionKey) as? AlertTransition
        }
        
        set {
            objc_setAssociatedObject(base, &transitionKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            guard let transtion = newValue else { return }
            
            base.transitioningDelegate = transtion
            base.modalPresentationStyle = .custom
            transtion.toController = base
            
            if let interactionTransition = transtion.interactionTransitionType?.init(transition: transtion) {
                interactionTransition.setup(presentingView: transtion.fromController?.view)
                transtion.interactionTransition = interactionTransition
            }
        }
    }
}


extension UIViewControllerContextTransitioning {
    var fromController: UIViewController? {
        return viewController(forKey: UITransitionContextViewControllerKey.from)
    }
    var toController: UIViewController? {
        return viewController(forKey: UITransitionContextViewControllerKey.to)
    }
    
    var fromView: UIView? {
        return view(forKey: UITransitionContextViewKey.from)
    }
    
    var toView: UIView? {
        return view(forKey: UITransitionContextViewKey.to)
    }
}
