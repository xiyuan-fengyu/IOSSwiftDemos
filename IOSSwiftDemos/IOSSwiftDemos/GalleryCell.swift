//
//  GalleryCell.swift
//  IOSSwiftDemos
//
//  Created by 邓伯操 on 16/6/18.
//  Copyright © 2016年 xiyuan. All rights reserved.
//

import UIKit

class GalleryItem: NSObject {
    
    var pic: String
    var title: String
    var picImage: UIImage?
    var titleColor: UIColor?
    
    init(pic: String, title: String) {
        self.pic = pic
        self.title = title
    }
}

class GalleryCell: UICollectionViewCell {
    
    @IBOutlet weak var picImg: UIImageView!
    
    @IBOutlet weak var titleLb: UILabel!
    
    func set(data: GalleryItem, index: Int) {
        if data.picImage == nil {
            if let tempImg = UIImage(named: data.pic) {
                data.picImage = tempImg
                NSThread(target: self, selector: #selector(self.computeImgDescribeColor), object: data).start()
            }
        }
        
        if data.picImage != nil {
            picImg.image = data.picImage
            titleLb.text = data.title
            
            if data.titleColor != nil {
                titleLb.textColor = data.titleColor
            }
        }
    }
    
    @objc func computeImgDescribeColor(data: Video) {
        data.titleColor = data.img?.describeTitleColor
        dispatch_async(dispatch_get_main_queue(), {
            self.titleLb.textColor = data.titleColor
        })
    }
    
}
