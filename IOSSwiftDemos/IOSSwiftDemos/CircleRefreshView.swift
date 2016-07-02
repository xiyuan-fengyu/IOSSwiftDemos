//
//  CircleRefreshView.swift
//  IOSSwiftDemos
//
//  Created by 邓伯操 on 16/6/27.
//  Copyright © 2016年 xiyuan. All rights reserved.
//

import UIKit

enum RefreshStatus {
    case Initial
    case ReleaseToRefresh
    case GotoRefresh
    case Refreshing
    case GotoInitial
}

enum LabelColorModel {
    case Special(color: UIColor)
    case SameWithCircle
}

class CircleRefreshView: UIView, UIScrollViewDelegate {
    
    private var size: CGFloat!
    
    private var maxRadius: CGFloat!
    
    private var circleLayer: CAShapeLayer!
    
    private var label: UILabel!
    
    private var centerOfCircle: CGPoint!
    
    private var isDragging: Bool = false
    
    private var curRefreshStatus = RefreshStatus.Initial {
        didSet {
            if let labelText = labelTextForRefreshStatus[curRefreshStatus] {
                self.label.text = labelText
            }
            else {
                self.label.text = ""
            }
        }
    }
    
    private var labelTextForRefreshStatus: [RefreshStatus: String] = [
        .Initial: "pull more",
        .ReleaseToRefresh: "release to refresh",
        .GotoRefresh: "loading...",
        .Refreshing: "loading..."
    ]

    private var labelColorModel: LabelColorModel = .Special(color: "#cccccc".toColor)
    
    private let minTimesOfHeightToRefresh: CGFloat = 1.5
    
    private var refreshDisplayLink: CADisplayLink! = nil
    
    private var colors: [UIColor] = ["#ff0000".toColor, "#fca009".toColor, "#47ff04".toColor, "#0be3fe".toColor, "#0948fd".toColor, "#ff3ee9".toColor]
    
    private var curColorIndex: Int = 0 {
        didSet {
            switch(labelColorModel) {
            case .SameWithCircle:
                self.label.textColor = colors[self.curColorIndex]
            default: ()
            }
        }
    }
    
    init(scrollView: UIScrollView, height: Int = 80) {
        let frame = CGRect(x: 0, y: -height, width: Int(scrollView.superview!.frame.width), height: height)
        super.init(frame: frame)
        
        size = min(frame.width, frame.height) / 5
        maxRadius = size / 2
        centerOfCircle = CGPointMake(size / 2, size / 2)
        
        circleLayer = CAShapeLayer()
        circleLayer.bounds = CGRectMake(0, 0, size, size)
        circleLayer.anchorPoint = CGPointMake(0.5, 0.5)
        circleLayer.position = CGPointMake(frame.width / 2, frame.height / 2)
        self.layer.addSublayer(circleLayer)
        
        label = UILabel(frame: CGRect(x: 0, y: CGFloat(height / 2) + maxRadius, width: frame.width, height: CGFloat(height / 2) - maxRadius))
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont.systemFontOfSize(12)
        setLabelColor()
        self.addSubview(label)
        
        
        scrollView.addObserver(self, forKeyPath: "contentOffset", options: NSKeyValueObservingOptions.init(rawValue: 0), context: nil)
        scrollView.addSubview(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setColors(colors: UIColor...) {
        if colors.count > 0 {
            self.colors = colors
        }
    }
    
    func setLabelTexts(texts: [RefreshStatus: String]) {
        labelTextForRefreshStatus.removeAll()
        for (key, value) in texts {
           labelTextForRefreshStatus[key] = value
        }
    }
    
    func setLabelFont(font: UIFont) {
        self.label.font = font
    }
    
    func setLabelColorModel(model: LabelColorModel) {
        self.labelColorModel = model
        setLabelColor()
    }
    
    private func setLabelColor() {
        switch labelColorModel {
        case .Special(let color):
            label.textColor = color
        default:
            label.textColor = colors[curColorIndex]
        }
    }
    
    private weak var refreshListener: AnyObject?
    
    private var refreshAction: Selector?
    
    func setRefreshListener(object: AnyObject, action: Selector) {
        refreshListener = object
        refreshAction = action
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        let scrollView = object as! UIScrollView
        let y = scrollView.contentOffset.y
        
        if scrollView.dragging != isDragging {
            isDragging = scrollView.dragging
            if !isDragging {
                if curRefreshStatus == .ReleaseToRefresh {
                    curRefreshStatus = .GotoRefresh
                }
            }
        }
        
        if curRefreshStatus == .Initial && -y >= self.frame.height * minTimesOfHeightToRefresh {
            curRefreshStatus = .ReleaseToRefresh
        }
        else if curRefreshStatus == .ReleaseToRefresh && -y < self.frame.height * minTimesOfHeightToRefresh {
            curRefreshStatus = .Initial
        }
        
        if curRefreshStatus == .GotoRefresh && -y <= self.frame.height {
            curRefreshStatus = .Refreshing
            startRefresh(false)
        }
        
        if curRefreshStatus == .Initial || curRefreshStatus == .ReleaseToRefresh || curRefreshStatus == .GotoRefresh {
            update(y)
        }
        else if curRefreshStatus == .GotoInitial {
            stopRefreshUpdate(y)
            if y >= -10 && y < 0 {
                curRefreshStatus = .Initial
                curColorIndex = 0
                angleSpeedIndex = 0
            }
        }
    }
    
    private var curStartAngle: CGFloat = 0
    private var curEndAngle: CGFloat = 0
    
    private let angleLimit = CGFloat(M_PI * 2)
    
    func startRefresh(animated: Bool = true) {
        if self.superview != nil {
            let scrollView = self.superview! as! UIScrollView
            scrollView.contentInset.top = self.frame.height
            scrollView.setContentOffset(CGPointMake(0, -self.frame.height), animated: animated)
            curRefreshStatus = .Refreshing
            startRefreshAnimation()
            
            if refreshListener != nil && refreshAction != nil {
                refreshListener!.performSelector(refreshAction!)
            }
        }
    }
    
    private func startRefreshAnimation() {
        curStartAngle = curEndAngle - CGFloat(M_PI * 0.4)
        
        if refreshDisplayLink == nil {
            refreshDisplayLink = CADisplayLink(target: self, selector: #selector(self.refreshUpdate))
        }
        refreshDisplayLink?.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
    }
    
    private var angleSpeedIndex: Double = 0
    
    private let indexRate: Double = 60
    
    private let minDisIndex: Double = 60 * 4 / 3
    
    private var minDistance = CGFloat(M_PI * 2)
    
    @objc private func refreshUpdate() {
        angleSpeedIndex += 1
        angleSpeedIndex %= (indexRate * 2)
        
        self.curEndAngle += CGFloat((sin(M_PI * angleSpeedIndex / indexRate) + 1.2) * M_PI / 40)
        self.curStartAngle += CGFloat((sin(M_PI * (angleSpeedIndex - indexRate / 3) / indexRate) + 1.2) * M_PI / 40)
        if self.curEndAngle > angleLimit {
            self.curEndAngle -= angleLimit
            curStartAngle -= angleLimit
        }
        
        if angleSpeedIndex == minDisIndex {
            curColorIndex += 1
            curColorIndex %= colors.count
        }
        
        self.drawCircle(self.maxRadius, startAngle: curStartAngle, endAngle: self.curEndAngle, color: self.colorByAlpha(colors[curColorIndex], alphaPercent: 1))
    }
    
    func stopRefresh() {
        if self.refreshDisplayLink != nil {
            self.refreshDisplayLink?.invalidate()
            self.refreshDisplayLink = nil
        }
        self.curRefreshStatus = .GotoInitial
        
        let scrollView = self.superview as! UIScrollView
        scrollView.contentInset.top = 0
        scrollView.contentOffset.y = -self.frame.height
        scrollView.setContentOffset(CGPointMake(0, 0), animated: true)
    }
    
    @objc private func stopRefreshUpdate(offsetY: CGFloat) {
        let radius = maxRadius * min(abs(offsetY), 100) / 100
        curEndAngle += CGFloat(M_PI * 0.02)
        drawCircle(radius, startAngle: curStartAngle, endAngle: curEndAngle, color: colorByAlpha(colors[curColorIndex], alphaPercent: radius / maxRadius))
    }
    
    private func update(offsetY: CGFloat) {
        let radius = maxRadius * min(abs(offsetY), 100) / 100
        curEndAngle = CGFloat(M_PI * 2) * abs(offsetY) / 100 - CGFloat(M_PI / 3)
        let startAngle = curEndAngle - CGFloat(M_PI * 3 / 4) * abs(offsetY) / 100
        drawCircle(radius, startAngle: startAngle, endAngle: curEndAngle, color: colorByAlpha(colors[curColorIndex], alphaPercent: radius / maxRadius))
    }
    
    private func drawCircle(radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat, color: UIColor) {
        let path = UIBezierPath(arcCenter: centerOfCircle, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        circleLayer.path = path.CGPath
        circleLayer.fillColor = UIColor.clearColor().CGColor
        circleLayer.strokeColor = color.CGColor
        circleLayer.lineWidth = CGFloat(6) * radius / size
    }
    
    private func colorByAlpha(color: UIColor, alphaPercent: CGFloat) -> UIColor {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        color.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return UIColor(red: r, green: g, blue: b, alpha: a * alphaPercent)
    }
    
    func destory() {
        if self.superview != nil {
            self.superview?.removeObserver(self, forKeyPath: "contentOffset")
        }
        
        if self.refreshDisplayLink != nil {
            self.refreshDisplayLink?.removeFromRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
            self.refreshDisplayLink?.invalidate()
            self.refreshDisplayLink = nil
        }
    }
    
}
