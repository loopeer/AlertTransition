//
//  LPPercentDrivenInteractiveTransition.swift
//  AlertTransition
//
//  Created by 韩帅 on 2017/4/17.
//  Copyright © 2017年 Loopeer. All rights reserved.
//

import UIKit

open class PercentDrivenInteractiveTransition: UIPercentDrivenInteractiveTransition {
    
    /// The transition used in
    public internal(set) weak var transition: AlertTransition?
    
    // flag, change this when state change
    public var isTransiting = false
    
    required public init(transition: AlertTransition) {
        self.transition = transition
    }
    
    // hook, called when transition is set to controller
    open func setup(presentingView: UIView?) { }
    open func setup(presentedView: UIView) { }
    open func deviceOrientationChanged() { }
}
