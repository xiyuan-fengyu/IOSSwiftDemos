//
//  RandomPickerController.swift
//  IOSSwiftDemos
//
//  Created by 123456 on 16/6/22.
//  Copyright © 2016年 xiyuan. All rights reserved.
//

import UIKit

class RandomPickerController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    private let emojiFont = UIFont(name: "Apple Color Emoji", size: 80)
    
    private let emojiData = ["😊", "😃", "😉", "😂", "😁", "😇", "😎", "😜", "😍", "😘", "😡", "😨", "😭", "😫", "😥"]
    
    private var pickerData: [[String]] = [[], [], []]
    
    @IBOutlet weak var randPicker: UIPickerView!
    
    @IBAction func randomBtClick(sender: AnyObject) {
        randPicker.selectRow(pickerData[0].count.arc4random, inComponent: 0, animated: true)
        randPicker.selectRow(pickerData[1].count.arc4random, inComponent: 1, animated: true)
        randPicker.selectRow(pickerData[2].count.arc4random, inComponent: 2, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for _ in 0..<100 {
            pickerData[0].append(emojiData[emojiData.count.arc4random])
            pickerData[1].append(emojiData[emojiData.count.arc4random])
            pickerData[2].append(emojiData[emojiData.count.arc4random])
        }
        
        randPicker.delegate = self
        randPicker.dataSource = self
        
        randPicker.selectRow(pickerData[0].count / 2, inComponent: 0, animated: false)
        randPicker.selectRow(pickerData[1].count / 2, inComponent: 1, animated: false)
        randPicker.selectRow(pickerData[2].count / 2, inComponent: 2, animated: false)
    }

    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 100
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 100
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        pickerLabel.text = pickerData[component][row]
        pickerLabel.font = emojiFont
        pickerLabel.textAlignment = NSTextAlignment.Center
        return pickerLabel
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
