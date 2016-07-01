//
//  SlideMenuCell.swift
//  IOSSwiftDemos
//
//  Created by 123456 on 16/6/23.
//  Copyright © 2016年 xiyuan. All rights reserved.
//

import UIKit

class SlideMenuItem: NSObject {
    var label: String!
    
    init(label: String) {
        self.label = label
    }
}

class SlideMenuCell: UITableViewCell {

    @IBOutlet weak var menuItemLb: UILabel!
    
    func set(data: SlideMenuItem, index: Int) {
        menuItemLb.text = data.label
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
