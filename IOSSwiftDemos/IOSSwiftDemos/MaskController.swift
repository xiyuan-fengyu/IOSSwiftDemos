//
//  MaskController.swift
//  IOSSwiftDemos
//
//  Created by 123456 on 16/6/22.
//  Copyright © 2016年 xiyuan. All rights reserved.
//

import UIKit

class MaskController: UIViewController {

    @IBOutlet weak var bgForMask: UIView!
    
    @IBOutlet weak var contentImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let mask = CALayer()
        mask.contents = UIImage(named: "icTwitter")?.CGImage
        mask.contentsGravity = kCAGravityResizeAspect
        let w = Int(view.frame.width) / 5
        let h = w * 926 / 1139
        mask.bounds = CGRect(x: 0, y: 0, width: w, height: h)
        mask.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        mask.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2)
        contentImg.layer.mask = mask
    }
    
    override func viewWillAppear(animated: Bool) {
        if bgForMask !== nil && contentImg.layer.mask != nil {
            animateMask(contentImg.layer.mask!)
        }
    }
    
    func animateMask(mask: CALayer) {
        let keyFrameAnimation = CAKeyframeAnimation(keyPath: "bounds")
        keyFrameAnimation.delegate = self
        keyFrameAnimation.duration = 0.6
        keyFrameAnimation.beginTime = CACurrentMediaTime() + 0.5
        keyFrameAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut), CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)]
        let initalBounds = NSValue(CGRect: mask.bounds)
        let secondBounds = NSValue(CGRect: CGRect(x: 0, y: 0, width: mask.bounds.width * 0.8, height: mask.bounds.height * 0.8))
        let finalBounds = NSValue(CGRect: CGRect(x: 0, y: 0, width: mask.bounds.width * 22, height: mask.bounds.height * 22))
        keyFrameAnimation.values = [initalBounds, secondBounds, finalBounds]
        keyFrameAnimation.keyTimes = [0, 0.5, 1.5]
        mask.addAnimation(keyFrameAnimation, forKey: "bounds")
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if contentImg.layer.mask !== nil {
            contentImg.layer.mask = nil
            bgForMask.removeFromSuperview()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
