//
//  UserPicCell.swift
//  IOSSwiftDemos
//
//  Created by 123456 on 16/6/23.
//  Copyright © 2016年 xiyuan. All rights reserved.
//

import UIKit

class UserPic: NSObject {
    var pic: String!
    var picTitle: String!
    var userPic: String!
    var userName: String!
    
    var picImg: UIImage?
    var userPicImg: UIImage?
    
    init(pic: String, picTitle: String, userPic: String, userName: String) {
        self.pic = pic
        self.picTitle = picTitle
        self.userPic = userPic
        self.userName = userName
        
        self.picImg = UIImage(named: pic)
        self.userPicImg = UIImage(named: userPic)
    }
}

class UserPicCell: UITableViewCell {

    @IBOutlet weak var picImg: UIImageView!
    
    @IBOutlet weak var userImg: UIImageView!
    
    @IBOutlet weak var titleLb: UILabel!
    
    @IBOutlet weak var userLb: UILabel!
    
    func set(data: UserPic, index: Int) {
        titleLb.text = data.picTitle
        userLb.text = data.userName
        if let img = data.picImg {
            picImg.image = img
        }
        if let img = data.userPicImg {
            userImg.image = img
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
