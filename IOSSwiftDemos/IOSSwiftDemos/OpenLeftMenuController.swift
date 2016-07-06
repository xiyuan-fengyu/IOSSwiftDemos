//
//  OpenLeftMenuController.swift
//  IOSSwiftDemos
//
//  Created by xiyuan_fengyu on 16/7/5.
//  Copyright © 2016年 xiyuan. All rights reserved.
//

import UIKit

class OpenLeftMenuController: UIViewController {

    private var leftMenuController: LeftMenuController!
    
    @IBAction func openMenuClick(sender: AnyObject) {
        leftMenuController.openMenu()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        leftMenuController = LeftMenuController()
        leftMenuController.addTo(self)
    }

    override func viewWillDisappear(animated: Bool) {
        self.leftMenuController.destory()
        self.leftMenuController = nil
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
