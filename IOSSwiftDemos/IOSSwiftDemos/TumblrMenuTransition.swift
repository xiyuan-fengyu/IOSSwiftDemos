//
//  TumblrMenuTransition.swift
//  IOSSwiftDemos
//
//  Created by 123456 on 16/6/23.
//  Copyright © 2016年 xiyuan. All rights reserved.
//

import UIKit

class TumblrMenuTransition: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    private var presenting = false
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let container = transitionContext.containerView()
        
        let screens : (from:UIViewController, to:UIViewController) = (transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!, transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!)
        
        let menuViewController = !self.presenting ? screens.from as! TumblrMenuController : screens.to as! TumblrMenuController
        let bottomViewController = !self.presenting ? screens.to as UIViewController : screens.from as UIViewController
        
        let menuView = menuViewController.view
        let bottomView = bottomViewController.view
        
        if (self.presenting) {
            
            self.offStageMenuController(menuViewController)
            
        }
        
        container!.addSubview(bottomView)
        container!.addSubview(menuView)
        
        let duration = self.transitionDuration(transitionContext)
        
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: [], animations: {
            
            if (self.presenting){
                
                self.onStageMenuController(menuViewController)
                
            } else {
                
                self.offStageMenuController(menuViewController)
                
            }
            
            }, completion: { finished in
                
                transitionContext.completeTransition(true)
                UIApplication.sharedApplication().keyWindow!.addSubview(screens.to.view)
                
        })
        
        
        
    }
    
    
    func offstage(amount: CGFloat) ->CGAffineTransform {
        return CGAffineTransformMakeTranslation(amount, 0)
    }
    
    func offStageMenuController(menuViewController: TumblrMenuController) {
        
        menuViewController.view.alpha = 0
        
        let topRowOffset  : CGFloat = 300
        let middleRowOffset : CGFloat = 150
        let bottomRowOffset  : CGFloat = 50
        
        menuViewController.textV.transform = self.offstage(-topRowOffset)
        
        menuViewController.quoteV.transform = self.offstage(-middleRowOffset)
        
        menuViewController.chatV.transform = self.offstage(-bottomRowOffset)
        
        menuViewController.photoV.transform = self.offstage(topRowOffset)
        
        menuViewController.linkV.transform = self.offstage(middleRowOffset)
        
        menuViewController.audioV.transform = self.offstage(bottomRowOffset)
        
    }
    
    func onStageMenuController(menuViewController: TumblrMenuController) {
        
        
        menuViewController.view.alpha = 1
        
        menuViewController.textV.transform = CGAffineTransformIdentity

        menuViewController.quoteV.transform = CGAffineTransformIdentity

        menuViewController.chatV.transform = CGAffineTransformIdentity

        menuViewController.photoV.transform = CGAffineTransformIdentity

        menuViewController.linkV.transform = CGAffineTransformIdentity

        menuViewController.audioV.transform = CGAffineTransformIdentity
        
    }
    
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.8
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        self.presenting = true
        return self
        
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        self.presenting = false
        return self
    }
    
}

