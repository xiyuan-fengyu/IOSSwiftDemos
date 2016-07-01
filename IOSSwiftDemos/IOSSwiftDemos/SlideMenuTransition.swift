//
//  SlideMenuTransition.swift
//  IOSSwiftDemos
//
//  Created by 123456 on 16/6/23.
//  Copyright © 2016年 xiyuan. All rights reserved.
//

import UIKit

class SlideMenuTransition: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    var duration = 0.5
    
    var isPresenting = false
    
    var toViewController: UIViewController?
    
    var snapshot: UIView? {
        
        didSet {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismiss))
            snapshot?.addGestureRecognizer(tapGestureRecognizer)
        }
        
    }
    
    func dismiss() {
        if let c = toViewController {
            c.dismissViewControllerAnimated(true, completion: {
                self.toViewController = nil
            })
        }
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        
        let container = transitionContext.containerView()
        let moveDown = CGAffineTransformMakeTranslation(0, container!.frame.height - 150)
        let moveUp = CGAffineTransformMakeTranslation(0, -50)
        
        if isPresenting {
            toView.transform = moveUp
            
            toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
            
            snapshot = fromView.snapshotViewAfterScreenUpdates(true)
            container!.addSubview(toView)
            container!.addSubview(snapshot!)
        }
        
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.3, options: .CurveEaseInOut, animations: {
            
            if self.isPresenting {
                self.snapshot?.transform = moveDown
                toView.transform = CGAffineTransformIdentity
            } else {
                self.snapshot?.transform = CGAffineTransformIdentity
                fromView.transform = moveUp
            }
            
            }, completion: { finished in
                
                transitionContext.completeTransition(true)
                if !self.isPresenting {
                    self.snapshot?.removeFromSuperview()
                }
        })
        
    }
    
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        return self
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        return self
    }
    
}