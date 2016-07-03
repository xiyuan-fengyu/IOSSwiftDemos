//
//  UIColorExt.swift
//  IOSSwiftDemos
//
//  Created by xiyuan_fengyu on 16/7/3.
//  Copyright © 2016年 xiyuan. All rights reserved.
//

import UIKit

extension UIColor {
    
    func byNewAlpha(alpha: CGFloat) -> UIColor {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return UIColor(red: r, green: g, blue: b, alpha: alpha)
    }
    
    func byAlphaPercent(percent: CGFloat) -> UIColor {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return UIColor(red: r, green: g, blue: b, alpha: a * percent)
    }
    
}
