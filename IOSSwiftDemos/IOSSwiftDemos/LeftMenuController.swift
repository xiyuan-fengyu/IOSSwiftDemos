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
    
    private var controller: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backImg = UIImageView(frame: self.view.frame)
        backImg.image = UIImage(named: "bg2")
        self.view.addSubview(backImg)
        
        menuView = UIView(frame: CGRect(x: -300, y: 0, width: 300, height: self.view.frame.height))
        self.view.addSubview(menuView)
    }
    
    func addTo(controller: UIViewController) {
        self.controller = controller
        self.controller.view.window!.addSubview(self.view)
        self.controller.view.window?.sendSubviewToBack(self.view)
    }
    
    func openMenu() {
        self.menuView.frame.origin.x = 0
        self.controller.view.frame.origin.x = 300
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
