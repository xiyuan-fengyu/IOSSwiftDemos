//
//  LoadingCoverController.swift
//  IOSSwiftDemos
//
//  Created by xiyuan_fengyu on 16/7/2.
//  Copyright © 2016年 xiyuan. All rights reserved.
//

import UIKit

class LoadingCoverController: UIViewController {

    @IBOutlet weak var backBt: UIButton!
    
    private var loadingCover: LoadingCoverView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadingCover = LoadingCoverView(root: self.view)
        
        self.view.bringSubviewToFront(backBt)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
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
