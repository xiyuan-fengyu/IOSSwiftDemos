//
//  InputLengthLimitController.swift
//  IOSSwiftDemos
//
//  Created by 123456 on 16/6/24.
//  Copyright © 2016年 xiyuan. All rights reserved.
//

import UIKit

class InputLengthLimitController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var inputTv: UITextView!
    
    @IBOutlet weak var lengthLimitLb: UILabel!
    
    private let maxLength = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputTv.delegate = self
        lengthLimitLb.text = "\(maxLength)"
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardWillShow), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardWillHide), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if range.length > maxLength {
            return false
        }
        
        let newLength = textView.text.characters.count - range.length + text.characters.count
        
        return newLength <= maxLength
    }
    
    func textViewDidChange(textView: UITextView) {
        lengthLimitLb.text = "\(maxLength - textView.text.characters.count)"
    }
    
    func keyboardWillShow(notification: NSNotification) {
        let userInfo  = notification.userInfo
        let keyBoardBounds = (userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let duration = (userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let deltaY = keyBoardBounds.size.height
        let animations:(() -> Void) = {
            
            self.lengthLimitLb.transform = CGAffineTransformMakeTranslation(0,-deltaY)
        }
        
        if duration > 0 {
            let options = UIViewAnimationOptions(rawValue: UInt((userInfo![UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).integerValue << 16))
            
            UIView.animateWithDuration(duration, delay: 0, options:options, animations: animations, completion: nil)
            
        }else {
            
            animations()
        }
    }
    

    func keyboardWillHide(notification: NSNotification) {
        let userInfo  = notification.userInfo
        let duration = (userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        
        let animations:(() -> Void) = {
            
            self.lengthLimitLb.transform = CGAffineTransformIdentity
            
        }
        
        if duration > 0 {
            let options = UIViewAnimationOptions(rawValue: UInt((userInfo![UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).integerValue << 16))
            
            UIView.animateWithDuration(duration, delay: 0, options:options, animations: animations, completion: nil)
            
        }else{
            
            animations()
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        inputTv.endEditing(true)
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
