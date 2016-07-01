//
//  UserPicController.swift
//  IOSSwiftDemos
//
//  Created by 123456 on 16/6/23.
//  Copyright © 2016年 xiyuan. All rights reserved.
//

import UIKit

class UserPicController: UITableViewController {
    
    private var userPicData = [
        UserPic(pic: "bg6", picTitle: "Nothing", userPic: "head0", userName: "Tom"),
        UserPic(pic: "bg7", picTitle: "Nothing", userPic: "head1", userName: "Cat"),
        UserPic(pic: "bg8", picTitle: "Nothing", userPic: "head2", userName: "Who"),
        UserPic(pic: "bg9", picTitle: "Nothing", userPic: "head3", userName: "Any"),
        UserPic(pic: "bg10", picTitle: "Nothing", userPic: "head4", userName: "Object")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userPicData.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return view.frame.width * 1500 / 2600
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UserPicCell", forIndexPath: indexPath) as! UserPicCell
        cell.set(userPicData[indexPath.row], index: indexPath.row)
        
        //设置cell选中之后的背景、
        cell.selectedBackgroundView = UIView(frame: cell.frame)
        cell.selectedBackgroundView?.backgroundColor = "#f0f0f0".toColor
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backToUserPic(segue: UIStoryboardSegue) {
        if let from = segue.sourceViewController as? SlideMenuController {
            if let curSelected = from.curSelected {
                self.title = curSelected
            }
            else {
                self.title = "UserPic"
            }
        }
    }
    
}
