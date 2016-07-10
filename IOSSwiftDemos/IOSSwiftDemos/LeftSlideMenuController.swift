//
//  LeftSlideMenuController.swift
//  IOSSwiftDemos
//
//  Created by xiyuan_fengyu on 16/7/10.
//  Copyright © 2016年 xiyuan. All rights reserved.
//

import UIKit

enum MenuStatus {
    case opening
    case opened
    case closing
    case closed
}

class LeftSlideMenuController: UIViewController, UIGestureRecognizerDelegate {

    func createMenuController() -> UIViewController {
        return UIViewController()
    }
    
    func createContentController() -> UIViewController {
        return UIViewController()
    }
    
    func createBackgroundView() -> UIView {
        return UIView(frame: self.view.frame)
    }
    
    private var menuController: UIViewController!
    
    private var contentController: UIViewController!
    
    private var panGesture: UIPanGestureRecognizer!
    
    private var _curMenuStatus: MenuStatus = .closed
    
    var curMenuStatus: MenuStatus {
        get {
            return _curMenuStatus
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(createBackgroundView())
        
        menuWidth = self.view.width * menuWidthPercent
        
        menuController = createMenuController()
        menuController.view.frame = CGRectMake(-menuWidth, 0, menuWidth, self.view.height)
        self.view.addSubview(menuController.view)
        
        
        contentController = createContentController()
        self.view.addSubview(contentController.view)
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.onPanGesture))
        panGesture.cancelsTouchesInView = true
        panGesture.delegate = self
        self.view.addGestureRecognizer(panGesture)
        
        
    }

    private var menuWidthPercent: CGFloat = 0.8
    
    private var menuWidth: CGFloat = 0
    
    private var contentScaleMin: CGFloat = 0.8
    
    private var curContentX: CGFloat = 0
    
    private var lastPanX: CGFloat = 0
    
    private var lastDeltaX: CGFloat = 0
    
    @objc private func onPanGesture(gesture: UIPanGestureRecognizer) {
        let curPan = gesture.translationInView(self.view)
        let curDeltaX = curPan.x - lastPanX
        curContentX += curDeltaX
        lastPanX = curPan.x
        if curContentX < 0 {
            curContentX = 0
        }
        else if curContentX > menuWidth {
            curContentX = menuWidth
        }
        contentController.view.x = curContentX
        let curContentScale = 1 - (1 - contentScaleMin) * curContentX / menuWidth
        contentController.view.transform = CGAffineTransformMakeScale(curContentScale, curContentScale)
        
        menuController.view.right = curContentX
        
        if gesture.state == UIGestureRecognizerState.Ended || gesture.state == UIGestureRecognizerState.Cancelled {
            if curContentX == menuWidth {
                _curMenuStatus = .opened
            }
            else if curContentX == 0 {
                _curMenuStatus = .closed
            }
            else if curContentX >= menuWidth * 0.3 && lastDeltaX > 0{
                openMenu()
            }
            else if curContentX < menuWidth * 0.3 || lastDeltaX < 0 {
                closeMenu()
            }
            lastPanX = 0
        }
        
        lastDeltaX = curDeltaX
    }
    
    private var menuDisplayLink: CADisplayLink!
    
    func openMenu() {
        controlMenuState = 1
        controlMenu()
        _curMenuStatus = .opening
    }
    
    func closeMenu() {
        controlMenuState = -1
        controlMenu()
        _curMenuStatus = .closing
    }
    
    private func controlMenu() {
        if menuDisplayLink != nil {
            menuDisplayLink.invalidate()
        }
        menuDisplayLink = CADisplayLink(target: self, selector: #selector(self.menuUpdate))
        menuDisplayLink.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
    }
    
    private var controlMenuState: CGFloat = 1
    
    private let menuMoveSpeed: CGFloat = 30
    
    @objc private func menuUpdate() {
        curContentX += menuMoveSpeed * controlMenuState
        if curContentX <= 0 {
            curContentX = 0
            menuDisplayLink.invalidate()
            menuDisplayLink = nil
            _curMenuStatus = .closed
        }
        else if curContentX >= menuWidth {
            curContentX = menuWidth
            menuDisplayLink.invalidate()
            menuDisplayLink = nil
            _curMenuStatus = .opened
        }
        contentController.view.x = curContentX
        let curContentScale = 1 - (1 - contentScaleMin) * curContentX / menuWidth
        contentController.view.transform = CGAffineTransformMakeScale(curContentScale, curContentScale)
        
        menuController.view.right = curContentX
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
