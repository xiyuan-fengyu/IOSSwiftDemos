//
//  OpenTumblrMenuController.swift
//  IOSSwiftDemos
//
//  Created by 123456 on 16/6/23.
//  Copyright © 2016年 xiyuan. All rights reserved.
//

import UIKit

class OpenTumblrMenuController: UIViewController {

    @IBOutlet weak var chooseMenuLb: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
    @IBAction func backToOpenTumblrMenu(segue: UIStoryboardSegue) {
        if let from = segue.sourceViewController as? TumblrMenuController {
            if let curSelected = from.curSelected {
                self.chooseMenuLb.text = curSelected
            }
            else {
                self.chooseMenuLb.text = ""
            }
        }
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
