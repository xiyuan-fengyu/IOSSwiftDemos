//
//  MajorColorController.swift
//  IOSSwiftDemos
//
//  Created by 邓伯操 on 16/6/16.
//  Copyright © 2016年 xiyuan. All rights reserved.
//

import UIKit

class MajorColorController: UIViewController {

    @IBOutlet weak var img0: UIImageView!
    
    @IBOutlet weak var img1: UIImageView!
    
    @IBOutlet weak var img2: UIImageView!
    
    @IBOutlet weak var img3: UIImageView!
    
    @IBOutlet weak var vMajorColor: UIView!
    
    private var colors: [UIColor] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        colors.append((img0.image?.majorColor(10))!)
        colors.append((img1.image?.majorColor(10))!)
        colors.append((img2.image?.majorColor(10))!)
        colors.append((img3.image?.majorColor(10))!)
        
        vMajorColor.backgroundColor = colors[0]
        
        self.img0.userInteractionEnabled = true
        self.img0.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(MajorColorController.onImgClick)))
        
        self.img1.userInteractionEnabled = true
        self.img1.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(MajorColorController.onImgClick)))
        
        self.img2.userInteractionEnabled = true
        self.img2.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(MajorColorController.onImgClick)))
        
        self.img3.userInteractionEnabled = true
        self.img3.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(MajorColorController.onImgClick)))
        
        self.vMajorColor.userInteractionEnabled = true
        self.vMajorColor.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(MajorColorController.onVMajorColorClick)))
    }
    
    func onVMajorColorClick(sender: UITapGestureRecognizer) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func onImgClick(sender: UITapGestureRecognizer) {
        let view = sender.view
        if view === img0 {
            vMajorColor.backgroundColor = colors[0]
        }
        else if view === img1 {
            vMajorColor.backgroundColor = colors[1]
        }
        else if view === img2 {
            vMajorColor.backgroundColor = colors[2]
        }
        else if view === img3 {
            vMajorColor.backgroundColor = colors[3]
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
