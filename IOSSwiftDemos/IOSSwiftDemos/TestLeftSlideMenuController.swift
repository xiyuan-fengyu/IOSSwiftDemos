//
//  TestLeftSlideMenuController.swift
//  IOSSwiftDemos
//
//  Created by xiyuan_fengyu on 16/7/10.
//  Copyright © 2016年 xiyuan. All rights reserved.
//

import UIKit

class TestLeftSlideMenuController: LeftSlideMenuController {
    
    override func createMenuController() -> UIViewController {
        return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("TestMenu")
    }
    
    override func createContentController() -> UIViewController {
        return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("TestContent")
    }
    
    override func createBackgroundView() -> UIView {
        let bg = UIImageView(frame: self.view.frame)
        bg.image = UIImage(named: "bg2")
        bg.clipsToBounds = true
        return bg
    }
    
    
}
