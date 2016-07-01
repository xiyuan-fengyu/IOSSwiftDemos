//
//  LoginAnimationController.swift
//  IOSSwiftDemos
//
//  Created by 123456 on 16/6/21.
//  Copyright © 2016年 xiyuan. All rights reserved.
//

import UIKit

class LoginAnimationController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameTf: UITextField!
    
    @IBOutlet weak var passwordTf: UITextField!
    
    @IBOutlet weak var loginBt: UIButton!
    
    @IBOutlet weak var usernameTfCenterX: NSLayoutConstraint!
    
    @IBOutlet weak var passwordTfCenterX: NSLayoutConstraint!
    
    @IBAction func loginBtClick(sender: AnyObject) {
        //涟漪动画
        let animation = CATransition()
        animation.delegate = self
        animation.duration = 1.0
        animation.type = "rippleEffect"
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        loginBt.layer.addAnimation(animation, forKey: nil)
        
        login()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        usernameTf.delegate = self
        passwordTf.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        usernameTfCenterX.constant -= view.frame.width
        passwordTfCenterX.constant -= view.frame.width
        loginBt.alpha = 0
    }
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(0.5, delay: 0.00, options: .CurveEaseOut, animations: {
            self.usernameTfCenterX.constant += self.view.frame.width
            self.view.layoutIfNeeded()
            
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.10, options: .CurveEaseOut, animations: {
            self.passwordTfCenterX.constant += self.view.frame.width
            self.view.layoutIfNeeded()
            
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.20, options: .CurveEaseOut, animations: {
            self.loginBt.alpha = 1
            self.view.layoutIfNeeded()
            
            }, completion: nil)
    }

    //重写键盘的return按键的响应
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if usernameTf === textField {
            passwordTf.becomeFirstResponder()
        }
        else if passwordTf === textField {
            login()
        }
        return true
    }
    
    func login() {
        //隐藏键盘
        self.view.endEditing(true)
        
    }
    
    //点击空白处隐藏键盘
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
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
