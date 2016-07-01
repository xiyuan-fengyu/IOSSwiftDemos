//
//  NewsCell.swift
//  IOSSwiftDemos
//
//  Created by 邓伯操 on 16/6/19.
//  Copyright © 2016年 xiyuan. All rights reserved.
//

import UIKit

class News: NSObject {
    
    var image: String
    var title: String
    
    init(image: String, title: String) {
        self.image = image
        self.title = title
    }
    
}

class NewsCell: UITableViewCell {

    @IBOutlet weak var newsImg: UIImageView!
    
    @IBOutlet weak var newsLb: UILabel!
    
    func set(data: News, index: Int) {
        if let tempImg = UIImage(named: data.image) {
            newsImg.image = tempImg
            newsLb.text = data.title
            newsLb.alignTop()
        }
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
