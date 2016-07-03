//
//  LoadingCoverView.swift
//  IOSSwiftDemos
//
//  Created by xiyuan_fengyu on 16/7/2.
//  Copyright © 2016年 xiyuan. All rights reserved.
//

import UIKit

class LoadingCoverView: UIView {
   
    private var layerCenter: CGPoint!
    
    private var dashLayer: CAShapeLayer!
    
    private var sandLayer: CAShapeLayer!
    
    private var sandLayerMask: CAShapeLayer!
    
    private var containerLayer: CAShapeLayer!
    
    private var loadingLayerDisplayLink: CADisplayLink!
    
    private var maskLayer: CAShapeLayer!
    
    private var maskLayerMaxRadius: CGFloat!
    
    private var maskLayerDisplayLink: CADisplayLink!
    
    private var containerColor: UIColor = "#50e0e0e0".toColor
    
    private var containeLineColor: UIColor = "#e0e0e0".toColor
    
    private var sandColor: UIColor = "#51b4fe".toColor
    
    func setContainerColor(color: UIColor) {
        containerColor = color
        containeLineColor = color.byNewAlpha(1)
        
        drawHourGlass(containerLayer, lineColor: containeLineColor, fillColor: containerColor)
    }
    
    func setSandColor(color: UIColor) {
        sandColor = color
        
        drawHourGlass(sandLayer, lineColor: UIColor.clearColor(), fillColor: sandColor)
    }
    
    init(root: UIView) {
        let w = root.frame.width
        let h = root.frame.height
        let frame = CGRect(x: 0, y: 0, width: w, height: h)
        super.init(frame: frame)
        root.addSubview(self)
        
        layerCenter = CGPointMake(w / 2, h / 2)
        
        containerLayer = CAShapeLayer()
        containerLayer.frame = CGRect(x: 0, y: 0, width: w, height: h)
        self.layer.addSublayer(containerLayer)
        drawHourGlass(containerLayer, lineColor: containeLineColor, fillColor: containerColor)
        
        dashLayer = CAShapeLayer()
        dashLayer.frame = CGRect(x: 0, y: 0, width: w, height: h)
        containerLayer.addSublayer(dashLayer)
        
        sandLayer = CAShapeLayer()
        sandLayer.frame = CGRect(x: 0, y: 0, width: w, height: h)
        containerLayer.addSublayer(sandLayer)
        drawHourGlass(sandLayer, lineColor: UIColor.clearColor(), fillColor: sandColor)
        
        sandLayerMask = CAShapeLayer()
        sandLayerMask.frame = CGRect(x: 0, y: 0, width: w, height: h)
        sandLayer.mask = sandLayerMask
        drawSandMask(0)
        
        maskLayerMaxRadius = pow(pow(w, 2) + pow(h, 2), 0.5) / 2 + 1
        maskLayerRadiusDelta = maskLayerMaxRadius / (60 * timeToMaskMaxRadius)
        
        maskLayer = CAShapeLayer()
        maskLayer.frame = CGRect(x: 0, y: 0, width: w, height: h)
        drawMask(0)
        self.layer.mask = maskLayer
        
        self.backgroundColor = "#ffffff".toColor
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var curShowCover = true
    
    func startLoading(showCover: Bool = true) {
        curShowCover = showCover
        curPercent = 0
        
        if !showCover {
            centerVisiblePercent = 1
            drawCenterMask(1)
        }
        
        self.hidden = false
        if loadingLayerDisplayLink != nil {
            loadingLayerDisplayLink.invalidate()
        }
        
        loadingLayerDisplayLink = CADisplayLink(target: self, selector: #selector(self.loadingUpdate))
        loadingLayerDisplayLink.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
    }
    
    private var curPercent: CGFloat = 0
    
    private var percentDelta: CGFloat = 0.005
    
    private var dashStartPoint = CGPoint(x: 100, y: 100)
    
    private var dashEndPoint = CGPoint(x: 100, y: 130)
    
    private let dashPerLen = 2
    
    private let dashPerDivide = 1
    
    private var dashOffenset = 0
    
    private let dashChangeRate = 12
    
    private var dashChangeIndex = 0
    
    func setSpeedScale(scale: CGFloat) {
        percentDelta *= scale
    }
    
    @objc private func loadingUpdate() {
        if !isRotating {
            dashChangeIndex -= 1
            if dashChangeIndex <= 0 {
                dashChangeIndex = dashChangeRate
                dashOffenset += 1
                dashOffenset %= (dashPerDivide + 1)
            }
            
            curPercent += percentDelta * pow(1.1 / (2.1 - curPercent), 2)
            if (curPercent >= 1) {
                curPercent = 1
                
                let animation = CABasicAnimation(keyPath: "transform.rotation.z")
                animation.toValue = 0
                animation.toValue = M_PI
                animation.duration = 1
                animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                animation.fillMode = kCAFillModeForwards
                animation.delegate = self
                containerLayer.addAnimation(animation, forKey: "transform.rotation.z")
            }
            drawDash(curPercent)
            drawSandMask(curPercent)
        }
    }
    
    private var isRotating = false
    
    override func animationDidStart(anim: CAAnimation) {
        isRotating = true
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        curPercent = 0
        drawSandMask(curPercent)
        isRotating = false
    }
    
    private func drawDash(percent: CGFloat) {
        let start = CGPointMake(center.x, center.y + CGFloat(dashOffenset))
        let end = CGPointMake(center.x, center.y + halfHeight * (1 - percent))
        
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, start.x, start.y)
        CGPathAddLineToPoint(path, nil, end.x, end.y)
        
        dashLayer.path = path
        dashLayer.fillColor = UIColor.clearColor().CGColor
        dashLayer.strokeColor = sandColor.CGColor
        dashLayer.lineWidth = 0.5
        dashLayer.lineDashPattern = [dashPerLen, dashPerDivide]
    }
    
    private let cornerRadiusDefault: CGFloat = 6
    
    private let halfWidthMinDefault: CGFloat = 1
    
    private let halfWidthMaxDefault: CGFloat = 14
    
    private let halfHeightDefault: CGFloat = 28
    
    private var cornerRadius: CGFloat = 6
    
    private var halfWidthMin: CGFloat = 1
    
    private var halfWidthMax: CGFloat = 14
    
    private var halfHeight: CGFloat = 28
    
    func setScale(scale: CGFloat) {
        cornerRadius = cornerRadiusDefault * scale
        halfWidthMin = max(halfWidthMinDefault * scale, 1)
        halfWidthMax = halfWidthMaxDefault * scale
        halfHeight = halfHeightDefault * scale
        
        drawHourGlass(containerLayer, lineColor: containeLineColor, fillColor: containerColor)
        drawHourGlass(sandLayer, lineColor: UIColor.clearColor(), fillColor: sandColor)
    }
    
    private func drawHourGlass(theLayer: CAShapeLayer, lineColor: UIColor, fillColor: UIColor) {
        let path = CGPathCreateMutable()
        CGPathAddArc(path, nil, layerCenter.x - halfWidthMax + cornerRadius, layerCenter.y - halfHeight + cornerRadius, cornerRadius, CGFloat(M_PI), CGFloat(M_PI * 1.5), false)
        CGPathAddLineToPoint(path, nil, layerCenter.x + halfWidthMax - cornerRadius, layerCenter.y - halfHeight)
        CGPathAddArc(path, nil, layerCenter.x + halfWidthMax - cornerRadius, layerCenter.y - halfHeight + cornerRadius, cornerRadius, CGFloat(M_PI * 1.5), CGFloat(M_PI * 2), false)
        CGPathAddLineToPoint(path, nil, layerCenter.x + halfWidthMin, layerCenter.y)
        
        CGPathAddLineToPoint(path, nil, layerCenter.x + halfWidthMax, layerCenter.y + halfHeight - cornerRadius)
        CGPathAddArc(path, nil, layerCenter.x + halfWidthMax - cornerRadius, layerCenter.y + halfHeight - cornerRadius, cornerRadius, CGFloat(0), CGFloat(M_PI * 0.5), false)
        CGPathAddLineToPoint(path, nil, layerCenter.x - halfWidthMax + cornerRadius, layerCenter.y + halfHeight)
        CGPathAddArc(path, nil, layerCenter.x - halfWidthMax + cornerRadius, layerCenter.y + halfHeight - cornerRadius, cornerRadius, CGFloat(M_PI * 0.5), CGFloat(M_PI), false)
        CGPathAddLineToPoint(path, nil, layerCenter.x - halfWidthMin, layerCenter.y)
        CGPathAddLineToPoint(path, nil, layerCenter.x - halfWidthMax, layerCenter.y - halfHeight + cornerRadius)
        
        theLayer.path = path
        theLayer.fillColor = fillColor.CGColor
        theLayer.strokeColor = lineColor.CGColor
        theLayer.lineWidth = 1
        theLayer.lineJoin = kCALineJoinRound
        theLayer.lineCap = kCALineCapRound
    }
    
    private func drawSandMask(percent: CGFloat) {
        let topRemainHeight = halfHeight * (1 - percent)
        let path = CGPathCreateMutable()
        CGPathAddRect(path, nil, CGRectMake(layerCenter.x - halfWidthMax, layerCenter.y - topRemainHeight, halfWidthMax * 2, topRemainHeight))
        CGPathAddRect(path, nil, CGRectMake(layerCenter.x - halfWidthMax, layerCenter.y + topRemainHeight, halfWidthMax * 2, halfHeight - topRemainHeight))
        sandLayerMask.path = path
        sandLayerMask.fillColor = UIColor.whiteColor().CGColor
        sandLayerMask.strokeColor = UIColor.whiteColor().CGColor
        sandLayerMask.lineWidth = 1
    }
    
    
    func stopLoading() {
        
        if loadingLayerDisplayLink != nil {
            loadingLayerDisplayLink.invalidate()
            loadingLayerDisplayLink = nil
        }
        
        if maskLayerDisplayLink != nil {
            maskLayerDisplayLink.invalidate()
        }
        
        maskLayerDisplayLink = CADisplayLink(target: self, selector: #selector(self.stopLoadingUpdate))
        maskLayerDisplayLink.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
    }
    
    //遮罩范围由0变为最大值maskLayerMaxRadius所需要的时间，单位为秒
    private let timeToMaskMaxRadius: CGFloat = 0.5
    
    private var curMaskLayerRadius: CGFloat = 0
    
    private var maskLayerRadiusDelta: CGFloat = 0
    
    @objc private func stopLoadingUpdate() {
        if curShowCover {
            curMaskLayerRadius += maskLayerRadiusDelta
            drawMask(curMaskLayerRadius)
            
            if curMaskLayerRadius >= maskLayerMaxRadius {
                maskLayerDisplayLink.invalidate()
                maskLayerDisplayLink = nil
                
                self.hidden = true
            }
        }
        else {
            centerVisiblePercent -= 0.05
            drawCenterMask(centerVisiblePercent)
            
            if centerVisiblePercent <= 0 {
                maskLayerDisplayLink.invalidate()
                maskLayerDisplayLink = nil
                
                self.hidden = true
            }
        }
        
        
     }
    
    private func drawMask(radius: CGFloat) {
        let lineWidth = maskLayerMaxRadius - radius
        let realRadius = radius + lineWidth / 2
        let path = UIBezierPath(arcCenter: layerCenter, radius: realRadius, startAngle: 0, endAngle: CGFloat(M_PI * 2), clockwise: true)
        maskLayer.path = path.CGPath
        maskLayer.fillColor = UIColor.clearColor().CGColor
        maskLayer.strokeColor = UIColor.whiteColor().CGColor
        maskLayer.lineWidth = lineWidth
    }

    private var centerVisiblePercent: CGFloat = 1
    
    private func drawCenterMask(percent: CGFloat) {
        let path = UIBezierPath(arcCenter: layerCenter, radius: (halfHeight + 15) * percent, startAngle: 0, endAngle: CGFloat(M_PI * 2), clockwise: true)
        maskLayer.path = path.CGPath
        maskLayer.fillColor = self.backgroundColor?.CGColor
        maskLayer.strokeColor = UIColor.clearColor().CGColor
        maskLayer.lineWidth = 1
    }
    
    func destry() {
        if loadingLayerDisplayLink != nil {
            loadingLayerDisplayLink.invalidate()
            loadingLayerDisplayLink = nil
        }
        
        if maskLayerDisplayLink != nil {
            maskLayerDisplayLink.invalidate()
            maskLayerDisplayLink = nil
        }
    }
    
}
