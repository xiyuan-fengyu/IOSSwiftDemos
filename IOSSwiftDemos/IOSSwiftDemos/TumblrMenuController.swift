//
//  TumblrMenuController.swift
//  IOSSwiftDemos
//
//  Created by 123456 on 16/6/23.
//  Copyright © 2016年 xiyuan. All rights reserved.
//

import UIKit

class TumblrMenuController: UIViewController {

    @IBOutlet weak var textV: UIView!
    
    @IBOutlet weak var photoV: UIView!
    
    @IBOutlet weak var quoteV: UIView!
    
    @IBOutlet weak var linkV: UIView!
    
    @IBOutlet weak var chatV: UIView!
    
    @IBOutlet weak var audioV: UIView!
    
    let transition = TumblrMenuTransition()
    
    var curSelected: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.transitioningDelegate = transition
        
        let sel = #selector(self.menuItemClick)
        textV.addOnClickListener(self, action: sel)
        photoV.addOnClickListener(self, action: sel)
        quoteV.addOnClickListener(self, action: sel)
        linkV.addOnClickListener(self, action: sel)
        chatV.addOnClickListener(self, action: sel)
        audioV.addOnClickListener(self, action: sel)
    }

    func menuItemClick(sender: UIGestureRecognizer) {
        if let v = sender.view {
            if v === textV {
                curSelected = "Text"
            }
            else if v === photoV {
                curSelected = "Photo"
            }
            else if v === quoteV {
                curSelected = "Photo"
            }
            else if v === linkV {
                curSelected = "Link"
            }
            else if v === chatV {
                curSelected = "Chat"
            }
            else if v === audioV {
                curSelected = "Audio"
            }
        }
        performSegueWithIdentifier("backToOpenTumblrMenu", sender: self)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        curSelected = nil
        performSegueWithIdentifier("backToOpenTumblrMenu", sender: self)
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
