//
//  UILabelExt.swift
//  IOSSwiftDemos
//
//  Created by 邓伯操 on 16/6/19.
//  Copyright © 2016年 xiyuan. All rights reserved.
//

import UIKit

extension UILabel {
    
    func alignTop() {
        let attr = [NSFontAttributeName: self.font]
        let fontSize = NSString(string: self.text!).sizeWithAttributes(attr)
        let h = self.frame.height
        let w = self.frame.width
        let strSize = NSString(string: self.text!).boundingRectWithSize(CGSizeMake(h, w), options: NSStringDrawingOptions.UsesFontLeading, attributes: attr, context: nil)
        let newLinesToPad = Int((h - strSize.height) / fontSize.height)
        self.numberOfLines = Int(h / fontSize.height) + 1
        for _ in 0..<newLinesToPad {
            self.text?.appendContentsOf("\n ")
        }
    }
    
    func alignBottom() {
        let attr = [NSFontAttributeName: self.font]
        let fontSize = NSString(string: self.text!).sizeWithAttributes(attr)
        let h = self.frame.height
        let w = self.frame.width
        let strSize = NSString(string: self.text!).boundingRectWithSize(CGSizeMake(h, w), options: NSStringDrawingOptions.UsesFontLeading, attributes: attr, context: nil)
        let newLinesToPad = Int((h - strSize.height) / fontSize.height)
        self.numberOfLines = Int(h / fontSize.height) + 1
        for _ in 0..<newLinesToPad {
            self.text? = "\n " + self.text!
        }
    }
    
}

