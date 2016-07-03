//
//  LoadingCoverController.swift
//  IOSSwiftDemos
//
//  Created by xiyuan_fengyu on 16/7/2.
//  Copyright © 2016年 xiyuan. All rights reserved.
//

import UIKit

class LoadingCoverController: UIViewController {

    private var loadingCover: LoadingCoverView!
    
    @IBAction func loadingBtClick(sender: AnyObject) {
        //不显示cover
        loadingCover.startLoading(false)
        refresh()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadingCover = LoadingCoverView(root: self.view)
        //设置cover层的背景色
        loadingCover.backgroundColor = "#eeffffff".toColor
//        //设置沙的颜色
//        loadingCover.setSandColor("#0db8fe".toColor)
//        //设置容器的颜色，一定要是透明色，否则看不到沙子那一层，容器壁的颜色为该颜色对应的完全不透明的颜色
//        loadingCover.setContainerColor("#40e0e0e0".toColor)
//        //设置大小
//        loadingCover.setScale(1)
        loadingCover.addOnClickListener(self, action: #selector(self.stopLoading))
    }
    
    deinit {
        loadingCover.destry()
    }
    
    override func viewDidAppear(animated: Bool) {
        //显示cover
        loadingCover.startLoading()
        refresh()
    }

    private func refresh() {
        //模拟网络加载导致的延时
        NSThread(target: self, selector: #selector(self.loadData), object: nil).start()
    }
    
    @objc func loadData() {
        sleep(UInt32(8.arc4random + 5))
        dispatch_async(dispatch_get_main_queue(), {
            self.loadingCover.stopLoading()
        })
    }
    
    @objc func stopLoading() {
        self.loadingCover.stopLoading()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
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
