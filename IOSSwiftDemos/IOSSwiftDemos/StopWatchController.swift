//
//  StopWatchController.swift
//  IOSSwiftDemos
//
//  Created by 123456 on 16/6/15.
//  Copyright © 2016年 xiyuan. All rights reserved.
//

import UIKit

class StopWatchController: UIViewController, OnTimeChanged {
    
    @IBOutlet weak var lbTime: UILabel!
    
    @IBOutlet weak var vStart: UIView!
    
    @IBOutlet weak var vStop: UIView!
    
    @IBOutlet weak var vReset: UIView!
    
    @IBAction func btBackClick(sender: AnyObject) {
        timer?.destory()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer(onTimeChanged: self)
        
        lbTime.font = UIFont(name: "NotCourierSans-Bold", size: 60)!
        
        vStart.userInteractionEnabled = true
        vStart.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(StopWatchController.onTap)))
        
        vStop.userInteractionEnabled = true
        vStop.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(StopWatchController.onTap)))
        
        vReset.userInteractionEnabled = true
        vReset.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(StopWatchController.onTap)))
    }
    
    func onTimeChanged(time: String) {
        lbTime.text = time
    }
    
    func onTap(sender: UITapGestureRecognizer) {
        let view = sender.view
        if view === vStart {
            timer?.start()
        }
        else if view === vStop {
            timer?.pause()
        }
        else if view === vReset {
            timer?.reset()
        }
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
