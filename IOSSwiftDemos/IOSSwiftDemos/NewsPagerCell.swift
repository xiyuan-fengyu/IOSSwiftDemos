//
//  NewsPagerCell.swift
//  IOSSwiftDemos
//
//  Created by 邓伯操 on 16/6/19.
//  Copyright © 2016年 xiyuan. All rights reserved.
//

import UIKit

class NewsPager: NSObject {
    
    var imgs: [String]
    
    init(imgs: [String]) {
        self.imgs = imgs
    }
    
}

class NewsPagerCell: UITableViewCell {

    @IBOutlet weak var newsPager: UIScrollView!
    
    func set(data: NewsPager, index: Int) {
        //由于cell是通过下面一句话来创建的
        //newsTbl.dequeueReusableCellWithIdentifier("NewsPagerCell", forIndexPath: indexPath) as!
        //所以cell创建好之后，其宽度和TableView等宽，然后用这个cell的frame设置newsPager，那么newsPager的宽度就正确了（如果不这样做，newsPager的默认宽度会是600）
        newsPager.frame = self.frame
        let scrollerFrame = self.frame
        let scrollerW = Float(self.frame.width)
        for i in data.imgs.indices {
            if let tempImg = UIImage(named: data.imgs[i]) {
                let imgFrame = scrollerFrame.offsetBy(dx: CGFloat(scrollerW * Float(i)), dy: 0)
                let img = UIImageView(frame: imgFrame)
                img.image = tempImg
                //如果contentMode = UIViewContentMode.ScaleAspectFill，但不设置clipsToBounds这个属性，则ImageView的高宽会受到图片比例的影响
                img.clipsToBounds = true
                img.contentMode = UIViewContentMode.ScaleAspectFill
                newsPager.addSubview(img)
            }
        }
        newsPager.contentSize = CGSize(width: CGFloat(scrollerW * Float(data.imgs.count)), height: scrollerFrame.height)
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
