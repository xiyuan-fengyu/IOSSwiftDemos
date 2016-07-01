//
//  UIImageUtil.swift
//  IOSSwiftDemos
//
//  Created by 123456 on 16/6/16.
//  Copyright © 2016年 xiyuan. All rights reserved.
//

import UIKit

extension UIImage {
    
    func majorColor(k: Int, samplePercent: Double = 0.001, ignoreClearColor: Bool = true) -> UIColor {
        let w = CGImageGetWidth(self.CGImage)
        let h = CGImageGetHeight(self.CGImage)
        let bitmapData = CGDataProviderCopyData(CGImageGetDataProvider(self.CGImage))
        let colorBytes = CFDataGetBytePtr(bitmapData)
        
        var colorArr: [(Double, Double, Double, Double)] = []
        
        let pixTotal = w * h
        let sampleNum = max(Int(Double(pixTotal) * samplePercent), 300)
        let sampleInterval = max(pixTotal / sampleNum, 1)
        for i in 0..<sampleNum {
            if i * sampleInterval + 3 < pixTotal {
                let r = Double(colorBytes.advancedBy(i * sampleInterval * 4 + 0).memory)
                let g = Double(colorBytes.advancedBy(i * sampleInterval * 4 + 1).memory)
                let b = Double(colorBytes.advancedBy(i * sampleInterval * 4 + 2).memory)
                let a = Double(colorBytes.advancedBy(i * sampleInterval * 4 + 3).memory)
                if !ignoreClearColor || a != 0 {
                    colorArr.append((r, g, b, a))
                }
            }
            
        }
        
        if colorArr.count > 0 {
            let kMean = KMean<(Double, Double, Double, Double)>(
                data: colorArr,
                k: k,
                nearestDis: 5,
                distance: {
                    (item0: (Double, Double, Double, Double), item1: (Double, Double, Double, Double)) -> Double in
                    let dis0 = pow(item0.0 - item1.0, 2.0)
                        + pow(item0.1 - item1.1, 2.0)
                        + pow(item0.2 - item1.2, 2.0)
                        + pow(item0.3 - item1.3, 2.0)
                    return pow(dis0, 0.5)
                },
                avg: {
                    (tArr: [(Double, Double, Double, Double)]) -> (Double, Double, Double, Double) in
                    var total = (0.0, 0.0, 0.0, 0.0)
                    for i in tArr.indices {
                        let item = tArr[i]
                        total.0 += item.0
                        total.1 += item.1
                        total.2 += item.2
                        total.3 += item.3
                    }
                    let count = Double(tArr.count)
                    return (total.0 / count, total.1 / count, total.2 / count, total.3 / count)
                }
            )
            let major = kMean.interation(10)[0]
            return UIColor.init(red: CGFloat(major.0 / 255.0), green: CGFloat(major.1 / 255.0), blue: CGFloat(major.2 / 255.0), alpha: CGFloat(major.3 / 255.0))
        }
        else {
            return UIColor.clearColor()
        }
    }
    
    
    var describeTitleColor: UIColor {
        get {
            let color = self.majorColor(5)
            let rgba = CGColorGetComponents(color.CGColor)

            let r = Float(rgba[0])
            let g = Float(rgba[1])
            let b = Float(rgba[2])
            let a = Float(rgba[3])
            
            let dis = abs(r - 0.5) + abs(g - 0.5) + abs(b - 0.5)
            if dis < 0.45 {
                var arr = [(0, r), (1, g), (2, b)]
                arr.sortInPlace {$0.0.1 < $0.1.1}
                arr[0].1 = 1 - arr[0].1 / 2.0
                arr[1].1 = 1
                arr[2].1 /= 2.0
                
                var tempR: Float = 0.0
                var tempG: Float = 0.0
                var tempB: Float = 0.0
                for (index, value) in arr {
                    switch index {
                    case 0:
                        tempR = value
                    case 1:
                        tempG = value
                    case 2:
                        tempB = value
                    default: ()
                    }
                }
                return UIColor.init(colorLiteralRed: tempR, green: tempG, blue: tempB, alpha: a)
            }
            return UIColor.init(colorLiteralRed: 1 - r, green: 1 - g, blue: 1 - b, alpha: a)
        }
    }
    
}