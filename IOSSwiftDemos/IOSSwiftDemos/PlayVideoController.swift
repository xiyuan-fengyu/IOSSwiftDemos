//
//  PlayVideoController.swift
//  IOSSwiftDemos
//
//  Created by 123456 on 16/6/17.
//  Copyright © 2016年 xiyuan. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class PlayVideoController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //注意：TableView默认有1px的分割线，导致content的高度比TableViewCell的高度小1，在滑动的时候分割线会闪烁，可以将TableView的sperator设置为none
    @IBOutlet weak var tblVideo: UITableView!
    
    private var videoData: [Video] = [
        Video(image: "videoScreenshot01", title: "Introduce 3DS Mario"),
        Video(image: "videoScreenshot02", title: "Emoji Among Us"),
        Video(image: "videoScreenshot03", title: "Seals Documentary"),
        Video(image: "videoScreenshot04", title: "Adventure Time"),
        Video(image: "videoScreenshot05", title: "Facebook HQ"),
        Video(image: "videoScreenshot06", title: "Lijiang Lugu Lake"),
        Video(image: "videoScreenshot07", title: "Polar Bear"),
        Video(image: "videoScreenshot08", title: "Beautiful Figure")
    ]
    
    private var playerController: AVPlayerViewController = AVPlayerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblVideo.delegate = self
        tblVideo.dataSource = self
    }
    
    @IBAction func onBtPlayClick(sender: AnyObject) {
        if let bt = sender as? UIButton {
            let index = bt.tag
            print("将要播放：" + videoData[index].title)
            if let url = NSBundle.mainBundle().URLForResource("testVideo", withExtension: "mp4") {
                let player = AVPlayer(URL: url)
                playerController.player = player
                self.presentViewController(playerController, animated: true, completion: {
                    self.playerController.player?.play()
                })
            }
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoData.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.view.frame.width / 414.0 * 220
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tblVideo.dequeueReusableCellWithIdentifier("VideoCell", forIndexPath: indexPath) as! VideoCell
        cell.set(videoData[indexPath.row], index: indexPath.row)
        return cell
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
