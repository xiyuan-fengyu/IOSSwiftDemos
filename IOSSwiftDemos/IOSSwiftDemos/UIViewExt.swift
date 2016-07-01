//
//  UIViewExt.swift
//  IOSSwiftDemos
//
//  Created by 邓伯操 on 16/6/28.
//  Copyright © 2016年 xiyuan. All rights reserved.
//

import UIKit

class UIViewManager {
    
    static var respondToClick: [UIView: Bool] = [:]
    
}

extension UIView {
    
    func addOnClickListener(target: AnyObject?, action: Selector) {
        self.userInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: target, action: action)
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        self.addGestureRecognizer(gesture)
        
        UIViewManager.respondToClick.updateValue(true, forKey: self)
    }
    
    public override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        if userInteractionEnabled {
            if UIViewManager.respondToClick.keys.contains(self) {
                UIView.animateWithDuration(0.05, animations: {
                    self.alpha = 0.3
                })
            }
        }
    }
    
    public override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        if userInteractionEnabled {
            if UIViewManager.respondToClick.keys.contains(self) {
                UIView.animateWithDuration(0.05, animations: {
                    self.alpha = 1
                })
            }
        }
    }
    
    public override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        super.touchesCancelled(touches, withEvent: event)
        if userInteractionEnabled {
            if UIViewManager.respondToClick.keys.contains(self) {
                UIView.animateWithDuration(0.05, animations: {
                    self.alpha = 1
                })
            }
        }
    }
    
}