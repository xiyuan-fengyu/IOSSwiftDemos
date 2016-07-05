//
//  OpenLeftMenuController.swift
//  IOSSwiftDemos
//
//  Created by xiyuan_fengyu on 16/7/5.
//  Copyright © 2016年 xiyuan. All rights reserved.
//

import UIKit

class LeftMenuController: UIViewController {

    
    @IBAction func openMenuClick(sender: AnyObject) {
        let v = UIView(frame: CGRect(x: 0, y: 0, width: 414, height: 200))
        v.backgroundColor = "#66ccff".toColor
        self.view.window?.addSubview(v)
        self.view.window?.bringSubviewToFront(v)
        self.view.transform = CGAffineTransformMakeScale(0.5, 0.5)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
