//
//  DemoCell.swift
//  IOSSwiftDemos
//
//  Created by 邓伯操 on 16/6/18.
//  Copyright © 2016年 xiyuan. All rights reserved.
//

import UIKit

class Demo {
    var name: String
    var nameColor: UIColor
    var describe: String
    
    init(name: String, nameColor: UIColor, describe: String) {
        self.name = name
        self.nameColor = nameColor
        self.describe = describe
    }
    
}

class DemoCell: UITableViewCell {

    @IBOutlet weak var lbName: UILabel!
    
    @IBOutlet weak var tvDescribe: UITextView!
    
    func set(data: Demo, index: Int) {
        lbName.text = data.name
        lbName.textColor = data.nameColor
        tvDescribe.text = data.describe
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
