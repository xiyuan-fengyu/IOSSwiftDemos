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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backImg = UIImageView(frame: self.view.frame)
        backImg.image = UIImage(named: "bg2")
        self.view.addSubview(backImg)
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
