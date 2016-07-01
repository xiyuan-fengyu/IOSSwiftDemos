//
//  TimeUtil.swift
//  IOSSwiftDemos
//
//  Created by 123456 on 16/6/20.
//  Copyright © 2016年 xiyuan. All rights reserved.
//

import Foundation

extension Double {
    
    var timeHMS: String {
        get {
            return Int(self).timeHMS
        }
    }
    
}

extension Int {
    
    var timeHMS: String {
        get {
            let s = self % 60
            let m = (self - s) / 60 % 60
            let h = (self - s - m * 60) / 3600
            return String(format: "%1$02d:%2$02d:%3$02d", arguments: [h, m, s])
        }
    }
    
}