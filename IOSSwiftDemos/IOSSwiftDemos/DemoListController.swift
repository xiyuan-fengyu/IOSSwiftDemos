//
//  DemoListController.swift
//  IOSSwiftDemos
//
//  Created by 123456 on 16/6/15.
//  Copyright © 2016年 xiyuan. All rights reserved.
//

import UIKit

class DemoListController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let demoData = [
        Demo(name: "LeftMenu", nameColor: "#ff890a".toColor, describe: "左侧拖出的菜单，右侧的内容在拖出过程中向右平移和缩小"),
        Demo(name: "StopWatch", nameColor: "#00ccff".toColor, describe: "秒表，子线程与主线程通信，子线程提醒主线程更新UI"),
        Demo(name: "Tab", nameColor: "#7a00b1".toColor, describe: "底部的Tab导航，设置TabBar的背景颜色透明性，TabBarItem的选中图标和标题的颜色设置"),
        Demo(name: "MajorColor", nameColor: "#49afcd".toColor, describe: "计算图片的主色调，采用KMean算法"),
        Demo(name: "ChangeFont", nameColor: "#cc99ff".toColor, describe: "使用自定义Font字体，需要添加ttf文件，并在list中注册"),
        Demo(name: "PlayVideo", nameColor: "#ff6699".toColor, describe: "TableView的使用，图片配字标题颜色的计算（图片的主色调的反色，灰色特殊考虑）"),
        Demo(name: "Gallery", nameColor: "#468847".toColor, describe: "图片模糊效果，画廊效果（相当于一个水平滚动的TableView）"),
        Demo(name: "Location", nameColor: "#34b91e".toColor, describe: "利用CoreLocation.framework来定位（注意：需要在info.plist中添加两个属性：NSLocationAlwaysUsageDescription，NSLocationWhenInUseUsageDescription）"),
        Demo(name: "Pager", nameColor: "#77ffcc".toColor, describe: "用ScrollView实现Pager效果"),
        Demo(name: "PullToRefresh", nameColor: "#8538f9".toColor, describe: "下拉刷新，在TableView中嵌入多种类型的cell，在cell里用ScrollView做Pager,UILabel扩展（靠顶部，靠底部）"),
        Demo(name: "PlayMusic", nameColor: "#7fa22d".toColor, describe: "播放歌曲（AVAudioPlayer），使用CAGradientLayer做一个渐变色层,用NSTimer提交周期性定时任务来改变背景色,用slider来现实和改变播放进度,且使用等宽字体（添加ttf字体）来显示时间"),
        Demo(name: "PhotoViewer", nameColor: "#56abe4".toColor, describe: "用ScrollView来实现一个图片查看器，支持手势缩放图片，拖动视窗"),
        Demo(name: "LoginWithVideoBg", nameColor: "#eb4f38".toColor, describe: "用视频作为背景"),
        Demo(name: "LoginAnimation", nameColor: "#673f09".toColor, describe: "一个简单的登陆界面，为输入框和登陆按钮添加出场动画，点击登陆按钮的时候同样有动画，点击空白处隐藏键盘，点击键盘return键跳到下一个输入框或者登陆"),
        Demo(name: "RandomPicker", nameColor: "#99cc66".toColor, describe: "用UIPickerView做一个随机的抽奖机"),
        Demo(name: "Mask", nameColor: "#66ccff".toColor, describe: "mask遮罩的用法，画面可视范围逐渐扩散"),
        Demo(name: "UserPic", nameColor: "#fea464".toColor, describe: "用NavigationBar来实现一个向下弹出的菜单（实际是弹出了一个新的页面）,在代码里调用绑定到Exit的segue"),
        Demo(name: "OpenTumblrMenu", nameColor: "#55fb85".toColor, describe: "打开新的一个页面来显示菜单，菜单页面背景半透明，有模糊效果，可以隐约看到前一个被覆盖的页面，菜单项分别从两侧出现，向中间并拢"),
        Demo(name: "InputLengthLimit", nameColor: "#ffc88c".toColor, describe: "TextField输入字数限制"),
        Demo(name: "RefreshView", nameColor: "#50fc8a".toColor, describe: "自定义刷新动画的UIVIew"),
        Demo(name: "CustomPullToRefresh", nameColor: "#3590fd".toColor, describe: "自定义下拉刷新的动画，当自定义View的实现里面用到NSTimer，CADisplayLink等会造成强引用环等情况，如何销毁资源，避免内存泄漏"),
        Demo(name: "LoadingCover", nameColor: "#1efeb3".toColor, describe: "页面加载动画，会用到mask"),
        
    ]
    
    @IBOutlet weak var demoList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        demoList.dataSource = self
        demoList.delegate = self
        
        //设置遮罩
        let mask = CALayer()
        mask.contents = UIImage(named: "icTwitter")?.CGImage
        mask.contentsGravity = kCAGravityResizeAspect
        let w = Int(view.frame.width) / 5
        let h = w * 926 / 1139
        let statusBarFrame = UIApplication.sharedApplication().statusBarFrame
        mask.bounds = CGRect(x: 0, y: 0, width: w, height: h)
        mask.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        mask.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2 - statusBarFrame.height)
        demoList.layer.mask = mask
    }
    
    @IBOutlet weak var bgViewForMask: UIView!
    
    override func viewWillAppear(animated: Bool) {
        //播放遮罩动画
        if bgViewForMask !== nil && demoList.layer.mask !== nil {
            animateMask(demoList.layer.mask!)
        }
    }
    
    func animateMask(mask: CALayer) {
        let keyFrameAnimation = CAKeyframeAnimation(keyPath: "bounds")
        keyFrameAnimation.delegate = self
        keyFrameAnimation.duration = 0.6
        keyFrameAnimation.beginTime = CACurrentMediaTime() + 0.5
        keyFrameAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut), CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)]
        let initalBounds = NSValue(CGRect: mask.bounds)
        let secondBounds = NSValue(CGRect: CGRect(x: 0, y: 0, width: mask.bounds.width * 0.8, height: mask.bounds.height * 0.8))
        let finalBounds = NSValue(CGRect: CGRect(x: 0, y: 0, width: mask.bounds.width * 22, height: mask.bounds.height * 22))
        keyFrameAnimation.values = [initalBounds, secondBounds, finalBounds]
        keyFrameAnimation.keyTimes = [0, 0.5, 1.5]
        mask.addAnimation(keyFrameAnimation, forKey: "bounds")
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if demoList.layer.mask !== nil {
            demoList.layer.mask = nil
            bgViewForMask.removeFromSuperview()
        }
    }    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return demoData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = demoList.dequeueReusableCellWithIdentifier("DemoCell", forIndexPath: indexPath) as! DemoCell
        cell.set(demoData[indexPath.row], index: indexPath.row)
        
        //设置cell选中之后的背景、
        cell.selectedBackgroundView = UIView(frame: cell.frame)
        cell.selectedBackgroundView?.backgroundColor = "#f0f0f0".toColor
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier(demoData[indexPath.row].name, sender: self)
    }
    
    
    @IBAction func backToDemoList(segue: UIStoryboardSegue) {

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if let identifier = segue.identifier {
//            if segue.destinationViewController is StopWatchController {
//                let destination = segue.destinationViewController as! StopWatchController
//                destination.demoName = identifier
//            }
//        }
    }

}
