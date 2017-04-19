//
//  BubbleTransition.swift
//  AlertTransition
//
//  Created by 韩帅 on 2017/4/19.
//  Copyright © 2017年 Loopeer. All rights reserved.
//

import UIKit
import AlertTransition

public class BubbleTransition: AlertTransition {

    var startingPoint = CGPoint.zero {
        didSet {
            bubble.center = startingPoint
        }
    }
    
    var bubbleColor: UIColor = .white
    
    fileprivate(set) var bubble = UIView()
    
    public override func performPresentedTransition(presentingView: UIView, presentedView: UIView, context: UIViewControllerContextTransitioning) {
        let originalCenter = presentedView.center
        let originalSize = presentedView.frame.size
        
        bubble = UIView()
        bubble.frame = frameForBubble(originalCenter, size: originalSize, start: startingPoint)
        bubble.layer.cornerRadius = bubble.frame.size.height / 2
        bubble.center = startingPoint
        bubble.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        bubble.backgroundColor = bubbleColor
        context.containerView.insertSubview(bubble, at: 0)
        
        presentedView.center = startingPoint
        presentedView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        presentedView.alpha = 0
        
        UIView.animate(withDuration: duration, animations: {
            self.bubble.transform = CGAffineTransform.identity
            presentedView.transform = CGAffineTransform.identity
            presentedView.alpha = 1
            presentedView.center = originalCenter
        }, completion: { (_) in
            context.completeTransition(true)
            
            self.fromController?.endAppearanceTransition()
            self.toController.endAppearanceTransition()
        })
    }
    
    public override func performDismissedTransition(presentingView: UIView, presentedView: UIView, context: UIViewControllerContextTransitioning) {
        bubble.frame = frameForBubble(presentedView.center, size: presentedView.frame.size, start: startingPoint)
        bubble.layer.cornerRadius = bubble.frame.size.height / 2
        bubble.center = startingPoint
        
        UIView.animate(withDuration: duration, animations: {
            self.bubble.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            presentedView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            presentedView.center = self.startingPoint
            presentedView.alpha = 0
            
        }, completion: { (_) in
            self.bubble.removeFromSuperview()
            context.completeTransition(true)
            
            self.fromController?.endAppearanceTransition()
            self.toController.endAppearanceTransition()
        })
    }
    
    func frameForBubble(_ originalCenter: CGPoint, size originalSize: CGSize, start: CGPoint) -> CGRect {
        let lengthX = fmax(start.x, originalSize.width - start.x)
        let lengthY = fmax(start.y, originalSize.height - start.y)
        let offset = sqrt(lengthX * lengthX + lengthY * lengthY) * 2
        let size = CGSize(width: offset, height: offset)
        
        return CGRect(origin: CGPoint.zero, size: size)
    }
}
