//
//  LeftSlideMenuController.swift
//  IOSSwiftDemos
//
//  Created by xiyuan_fengyu on 16/7/10.
//  Copyright © 2016年 xiyuan. All rights reserved.
//

import UIKit

class LeftSlideMenuController: UIViewController {

    func createMenuController() -> UIViewController {
        return UIViewController()
    }
    
    func createContentController() -> UIViewController {
        return UIViewController()
    }
    
    private var menuController: UIViewController!
    
    private var contentController: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        menuController = createMenuController()
        contentController = createContentController()
        
//        self.view.addSubview(menuController)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
