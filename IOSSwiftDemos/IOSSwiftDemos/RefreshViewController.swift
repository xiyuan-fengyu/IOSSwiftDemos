//
//  RefreshViewController.swift
//  IOSSwiftDemos
//
//  Created by 123456 on 16/6/24.
//  Copyright © 2016年 xiyuan. All rights reserved.
//

import UIKit

class RefreshViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let refreshView = XYRefreshView(frame: self.view.frame, color: "#cccccc".toColor)
        self.view.addSubview(refreshView)
        view.sendSubviewToBack(refreshView)
        refreshView.start()
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
