//
//  LoginWithVideoBgController.swift
//  IOSSwiftDemos
//
//  Created by 123456 on 16/6/20.
//  Copyright © 2016年 xiyuan. All rights reserved.
//

import UIKit

class LoginWithVideoBgController: VideoBgController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let videoUrl = NSBundle.mainBundle().URLForResource("loginBg", withExtension: "mp4") {
            playerFrame = self.view.frame
            fillMode = .ResizeAspectFill
            alwaysRepeat = true
            sound = 1.0
            alpha = 0.8
            play(videoUrl, startTime: 2.0, duration: 0.0)
        }
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
