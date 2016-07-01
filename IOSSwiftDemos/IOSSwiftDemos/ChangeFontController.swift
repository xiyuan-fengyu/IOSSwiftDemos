//
//  ChangeFontController.swift
//  IOSSwiftDemos
//
//  Created by 123456 on 16/6/17.
//  Copyright © 2016年 xiyuan. All rights reserved.
//

import UIKit

class ChangeFontController: UIViewController {

    @IBOutlet weak var tvContent: UITextView!
    
    private var fonts: [UIFont] = []
    
    private var fontIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //引入字体的注意事项：
        //1.添加ttf字体时，右键group文件夹 Add Files To 。。。，不要从Finder中直接拖拽导入，这样会导致路径错误而找不到ttf文件
        //2.要将字体文件名添加到info.list中，新建一个Fonts provided by application字段，然后加入所有字体ttf文件名（包括后缀）
        
        //打印当前可用的所有family和font
//        for family in UIFont.familyNames() {
//            print(family)
//            for font in UIFont.fontNamesForFamilyName(family){
//                print(font)
//            }
//            print("\n")
//        }
        
        fonts.append(UIFont.systemFontOfSize(17))
        fonts.append(UIFont(name: "MFZhiHei_Noncommercial-Regular", size: 17)!)
        
        
        //通过NSAttributedString设置行间距
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        let attrs = [NSFontAttributeName: fonts[fontIndex],
                     NSParagraphStyleAttributeName: paragraphStyle]
        tvContent.attributedText = NSAttributedString.init(string: "点击切换字体\n😊\n1 2 3 4 5\na b c d e\nA B C D E", attributes: attrs)
        
        tvContent.userInteractionEnabled = true
        tvContent.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.onViewTap)))
    }

    func onViewTap(sender: UITapGestureRecognizer) {
        fontIndex += 1
        fontIndex %= fonts.count
        tvContent.font = fonts[fontIndex]
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
