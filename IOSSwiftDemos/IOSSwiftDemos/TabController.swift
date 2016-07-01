//
//  TabController.swift
//  IOSSwiftDemos
//
//  Created by 123456 on 16/6/16.
//  Copyright © 2016年 xiyuan. All rights reserved.
//

import UIKit

class TabController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //关闭tabBar半透明效果
//        self.tabBar.translucent = false

        //设置tabBar背景色
        self.tabBar.barTintColor = "#f6f6f6".toColor
        
        //统一设置item 选中后icon，文字的颜色
//        self.tabBar.tintColor = UIColor.redColor()
        
        //设置TabBarItem选中后的效果，采用原本的图片，覆盖默认的蓝色效果
        var tabBarItems = self.tabBar.items!
        for i in tabBarItems.indices {
            let img = UIImage(named: "iconTabBarItem\(i)")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
            tabBarItems[i].selectedImage = img
            tabBarItems[i].setTitleTextAttributes([NSForegroundColorAttributeName: img.majorColor(2)], forState: UIControlState.Selected)
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
