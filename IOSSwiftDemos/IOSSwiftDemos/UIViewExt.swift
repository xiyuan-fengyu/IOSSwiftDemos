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
    
    var x: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            self.frame.origin.x = newValue
        }
    }
    
    var y: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            self.frame.origin.y = newValue
        }
    }
    
    var origin: CGPoint {
        get {
            return self.frame.origin
        }
        set {
            self.frame.origin = newValue
        }
    }

    var width: CGFloat {
        get {
            return self.frame.width
        }
        set {
            var f = self.frame
            f.size.width = newValue
            self.frame = f
        }
    }
    
    var height: CGFloat {
        get {
            return self.frame.height
        }
        set {
            var f = self.frame
            f.size.height = newValue
            self.frame = f
        }
    }
    
    var size: CGSize {
        get {
            return self.frame.size
        }
        set {
            var f = self.frame
            f.size = newValue
            self.frame = f
        }
    }
    
    var right: CGFloat {
        get {
            return self.frame.origin.x + self.frame.width
        }
        set {
            self.frame.origin.x = newValue - self.frame.width
        }
    }
    
    var bottom: CGFloat {
        get {
            return self.frame.origin.y + self.frame.height
        }
        set {
            self.frame.origin.y = newValue - self.frame.height
        }
    }
    
    var centerX: CGFloat {
        get {
            return self.center.x
        }
        set {
            self.center = CGPointMake(newValue, self.center.y)
        }
    }
    
    var centerY: CGFloat {
        get {
            return self.center.y
        }
        set {
            self.center = CGPointMake(self.center.x, newValue)
        }
    }
    
    var lastSubviewOnX: UIView? {
        get {
            if self.subviews.count > 0 {
                var result = self.subviews[0]
                for v in self.subviews {
                    if (v.x > result.x) {
                        result = v
                    }
                }
                return result
            }
            else {
                return nil
            }
        }
    }
    
    var lastSubviewOnY: UIView? {
        get {
            if self.subviews.count > 0 {
                var result = self.subviews[0]
                for v in self.subviews {
                    if (v.y > result.y) {
                        result = v
                    }
                }
                return result
            }
            else {
                return nil
            }
        }
    }
    
    func removeAllSubviews() {
        for v in self.subviews {
            v.removeFromSuperview()
        }
    }
    
}
























