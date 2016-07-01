//
//  PullToRefreshController.swift
//  IOSSwiftDemos
//
//  Created by 邓伯操 on 16/6/19.
//  Copyright © 2016年 xiyuan. All rights reserved.
//

import UIKit

class PullToRefreshController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var newsPagerData = NewsPager(imgs: ["gjqt0", "gjqt1", "gjqt2", "gjqt3", "gjqt4", "gjqt5"])
    
    private var newsData = [
        News(image: "videoScreenshot01", title: "Introduce 3DS Mario"),
        News(image: "videoScreenshot02", title: "Emoji Among Us"),
        News(image: "videoScreenshot03", title: "Seals Documentary"),
        News(image: "videoScreenshot04", title: "Adventure Time"),
        News(image: "videoScreenshot05", title: "Facebook HQ"),
        News(image: "videoScreenshot06", title: "Lijiang Lugu Lake"),
        News(image: "videoScreenshot07", title: "Polar Bear"),
        News(image: "videoScreenshot08", title: "Beautiful Figure")
    ]
    
    @IBOutlet weak var newsTbl: UITableView!
    
    private var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        newsTbl.delegate = self
        newsTbl.dataSource = self
        
        //采用默认的拖拽距离和触发条件
        refreshControl.addTarget(self, action: #selector(self.refresh), forControlEvents: UIControlEvents.ValueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "loading...")
        
        newsTbl.addSubview(refreshControl)
    }
    
    //重写默认的拖拽距离和触发条件，不建议这种方式
//    func scrollViewDidScroll(scrollView: UIScrollView) {
//        if scrollView.contentOffset.y < -100 && !refreshControl.refreshing {
//            refreshControl.beginRefreshing()
//            refresh()
//        }
//    }
    
    func refresh() {
        //模拟网络加载导致的延时
        NSThread(target: self, selector: #selector(self.loadData), object: nil).start()
    }
    
    @objc func loadData() {
        sleep(2)
        dispatch_async(dispatch_get_main_queue(), {
            let randIndex = 9.arc4random
            let randName = "videoScreenshot0\(randIndex)"
            self.newsData.insert(News(image: randName, title: randName), atIndex: 0)
            self.newsTbl.reloadData()
            self.refreshControl.endRefreshing()
        })
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + newsData.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 250.0
        }
        return 160
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = newsTbl.dequeueReusableCellWithIdentifier("NewsPagerCell", forIndexPath: indexPath) as! NewsPagerCell
            cell.set(newsPagerData, index: indexPath.row)
            return cell
        }
        else {
            let cell = newsTbl.dequeueReusableCellWithIdentifier("NewsCell", forIndexPath: indexPath) as! NewsCell
            cell.set(newsData[indexPath.row - 1], index: indexPath.row)
            
            //设置cell选中之后的背景、
            cell.selectedBackgroundView = UIView(frame: cell.frame)
            cell.selectedBackgroundView?.backgroundColor = "#f0f0f0".toColor
            return cell
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
