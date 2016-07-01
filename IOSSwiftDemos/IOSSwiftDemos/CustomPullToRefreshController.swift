//
//  CustomPullToRefreshController.swift
//  IOSSwiftDemos
//
//  Created by 123456 on 16/6/24.
//  Copyright © 2016年 xiyuan. All rights reserved.
//

import UIKit

class CustomPullToRefreshController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var testTbl: UITableView!
    
    private var userPicData = [
        UserPic(pic: "bg6", picTitle: "Nothing", userPic: "head0", userName: "Tom"),
        UserPic(pic: "bg7", picTitle: "Nothing", userPic: "head1", userName: "Cat"),
        UserPic(pic: "bg8", picTitle: "Nothing", userPic: "head2", userName: "Who"),
        UserPic(pic: "bg9", picTitle: "Nothing", userPic: "head3", userName: "Any"),
        UserPic(pic: "bg10", picTitle: "Nothing", userPic: "head4", userName: "Object")
    ]
    
    private var refreshControl: UIRefreshControl!
    private var refreshView: XYRefreshView!
    
    private var circleRefreshView: CircleRefreshView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testTbl.delegate = self
        testTbl.dataSource = self
        
        circleRefreshView = CircleRefreshView(frame: CGRect(x: 0, y: -80, width: Int(self.view.frame.width), height: 80))
//        circleRefreshView.backgroundColor = "#f0f0f0".toColor
        circleRefreshView.setRefreshListener(self, action: #selector(self.refresh))
        circleRefreshView.addTo(testTbl)
    }
    
    override func viewDidAppear(animated: Bool) {
        circleRefreshView.startRefresh()
    }

    deinit {
        circleRefreshView.destory()
    }
    
   
    func refresh() {
        //模拟网络加载导致的延时
        NSThread(target: self, selector: #selector(self.loadData), object: nil).start()
    }
    
    @objc func loadData() {
        sleep(UInt32(4.arc4random + 2))
        dispatch_async(dispatch_get_main_queue(), {
            self.userPicData.insert(UserPic(pic: "bg\(5.arc4random + 6)", picTitle: "Nothing", userPic: "head\(5.arc4random)", userName: self.userPicData[self.userPicData.count.arc4random].userName), atIndex: 0)
            self.testTbl.reloadData()
            self.circleRefreshView.stopRefresh()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userPicData.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return view.frame.width * 1500 / 2600
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UserPicCell", forIndexPath: indexPath) as! UserPicCell
        cell.set(userPicData[indexPath.row], index: indexPath.row)
        
        //设置cell选中之后的背景、
        cell.selectedBackgroundView = UIView(frame: cell.frame)
        cell.selectedBackgroundView?.backgroundColor = "#f0f0f0".toColor
        return cell
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
