//
//  LeftMenuController.swift
//  IOSSwiftDemos
//
//  Created by xiyuan_fengyu on 16/7/6.
//  Copyright © 2016年 xiyuan. All rights reserved.
//

import UIKit

class LeftMenuController: UIViewController {
    
    private var backImg: UIImageView!
    
    private var menuView: UIView!
    
    private var menuWidth: CGFloat!
    
    private var controller: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backImg = UIImageView(frame: self.view.frame)
        backImg.image = UIImage(named: "bg2")
        self.view.addSubview(backImg)
        
        menuWidth = self.view.frame.width * 0.7
        
        menuView = UIView(frame: CGRect(x: -menuWidth, y: 0, width: menuWidth, height: self.view.frame.height))
        menuView.backgroundColor = "#99f0f0f0".toColor
        self.view.addSubview(menuView)
    }
    
    func addTo(controller: UIViewController) {
        self.controller = controller
        self.controller.view.window!.addSubview(self.view)
        self.controller.view.window?.sendSubviewToBack(self.view)
    }
    
    func openMenu() {
        self.menuView.frame.origin.x = 0
        self.controller.view.frame.origin.x = menuWidth - self.controller.view.frame.width * 0.1
        self.controller.view.transform = CGAffineTransformMakeScale(0.8, 0.8)
    }
    
    func destory() {
        self.view.removeFromSuperview()
        self.controller = nil
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
