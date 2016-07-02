//
//  LoadingCoverView.swift
//  IOSSwiftDemos
//
//  Created by xiyuan_fengyu on 16/7/2.
//  Copyright © 2016年 xiyuan. All rights reserved.
//

import UIKit

class LoadingCoverView: UIView {

    private var maskLayer: CAShapeLayer!
    
    private weak var maskLayerDisplayLink: CADisplayLink!
    
    init(root: UIView) {
        let frame = CGRect(x: 0, y: 0, width: root.frame.width, height: root.frame.height)
        super.init(frame: frame)
        root.addSubview(self)
        
        maskLayer = CAShapeLayer()
        maskLayer.frame = CGRect(x: 0, y: 0, width: root.frame.width, height: root.frame.height)
        maskLayer.backgroundColor = UIColor.whiteColor().CGColor
        self.layer.mask = maskLayer
        
        self.backgroundColor = "#f0f0f0".toColor
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func stopLoading() {
        maskLayerDisplayLink = CADisplayLink(target: self, selector: #selector(self.stopLoadingUpdate))
    }
    
    @objc private func stopLoadingUpdate() {
        
    }

}
