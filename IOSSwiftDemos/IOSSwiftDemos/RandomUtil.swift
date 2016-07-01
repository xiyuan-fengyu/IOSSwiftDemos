//
//  RandomUtil.swift
//  IOSSwiftDemos
//
//  Created by 123456 on 16/6/16.
//  Copyright © 2016年 xiyuan. All rights reserved.
//

import Foundation

extension Int {

    var arc4random: Int {
        get {
            if(self == 0) {
                return 0
            }
            else {
                var r = 0
                arc4random_buf(&r, sizeof(Int))
                return abs(r % self)
            }
        }
    }
    
    //在固定间隔，周期性产生随机数的情况，这种方式并不好，随机数会周期性变化
    var rand48: Int {
        get {
            srand48(Int(time(nil)))
            return Int(drand48() * Double(self))
        }
    }
    
}