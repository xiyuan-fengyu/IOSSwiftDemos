//
//  VideoCell.swift
//  IOSSwiftDemos
//
//  Created by 123456 on 16/6/17.
//  Copyright © 2016年 xiyuan. All rights reserved.
//

import UIKit

class Video: NSObject {
    var image: String
    var title: String
    var img: UIImage?
    var titleColor: UIColor?
    
    
    init(image: String, title: String) {
        self.image = image
        self.title = title
    }
}

class VideoCell: UITableViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var btPlay: UIButton!
    @IBOutlet weak var title: UILabel!
    
    func set(data: Video, index: Int) {
        if data.img == nil {
            if let tempImg = UIImage(named: data.image) {
                data.img = tempImg
                NSThread(target: self, selector: #selector(self.computeImgDescribeColor), object: data).start()
            }
        }
        
        if data.img != nil {
            img.image = data.img
            title.text = data.title
            if data.titleColor != nil {
                title.textColor = data.titleColor
            }
            
            btPlay.tag = index
        }
    }
    
    @objc func computeImgDescribeColor(data: Video) {
        data.titleColor = data.img?.describeTitleColor
        dispatch_async(dispatch_get_main_queue(), {
            self.title.textColor = data.titleColor
        })
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
