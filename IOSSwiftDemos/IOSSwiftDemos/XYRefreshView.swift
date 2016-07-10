//
//  XYRefreshView.swift
//  IOSSwiftDemos
//
//  Created by 123456 on 16/6/24.
//  Copyright © 2016年 xiyuan. All rights reserved.
//

import UIKit

class XYRefreshView: UIView {

    private var circleSize: CGFloat!
    
    private var maxRadius: CGFloat!

    private var layerColor: (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) = (r: 0.0, g: 0.0, b: 0.0, a: 0.0)
    
    private let layerNum: Int = 4
    
    private var layers: [CAShapeLayer] = []
    
    private var progress: [CGFloat] = []
    
    private var timer: NSTimer?
    
    init(frame: CGRect, color: UIColor) {
        super.init(frame: frame)
        
        circleSize = min(frame.width, frame.height) / 2
        maxRadius = circleSize / 2
        
        var tempR: CGFloat = 0.0
        var tempG: CGFloat = 0.0
        var tempB: CGFloat = 0.0
        var tempA: CGFloat = 0.0
        color.getRed(&tempR, green: &tempG, blue: &tempB, alpha: &tempA)
        layerColor.r = tempR
        layerColor.g = tempG
        layerColor.b = tempB
        layerColor.a = tempA
        
        var tempTime: CGFloat = 0.0
        for _ in 0..<layerNum {
            let tempLayer = CAShapeLayer()
            tempLayer.bounds = CGRectMake(0, 0, circleSize, circleSize)
            tempLayer.anchorPoint = CGPointMake(0.5, 0.5)
            tempLayer.position = self.center
            self.layer.addSublayer(tempLayer)
            
            layers.append(tempLayer)
            progress.append(tempTime)
            tempTime -= 0.4 / CGFloat(progress.count)
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func start() {
        timer = NSTimer.scheduledTimerWithTimeInterval(0.08, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
    }

    func update() {
        for i in 0..<layerNum {
            progress[i] += 0.05
            if progress[i] >= 0 {
                drawLayer(layers[i], radiusPercent: min(progress[i], 1))
                if progress[i] > 1 {
                    progress[i] = -0.5
                }
            }
        }
    }
    
    
    func stop() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
    
    func drawLayer(layer: CAShapeLayer, radiusPercent: CGFloat) {
        let path = UIBezierPath(arcCenter: CGPointMake(layer.bounds.width / 2, layer.bounds.height / 2), radius: maxRadius * radiusPercent, startAngle: 0, endAngle: CGFloat(M_PI * 2), clockwise: true)
        layer.path = path.CGPath
        
        let c = UIColor(red: layerColor.r, green: layerColor.g, blue: layerColor.b, alpha: layerColor.a * (1 - radiusPercent)).CGColor
        layer.fillColor = c
        layer.strokeColor = c
    }
    
}
