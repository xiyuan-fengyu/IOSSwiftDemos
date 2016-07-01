//
//  GalleryController.swift
//  IOSSwiftDemos
//
//  Created by 邓伯操 on 16/6/18.
//  Copyright © 2016年 xiyuan. All rights reserved.
//

import UIKit

class GalleryController: UIViewController, UICollectionViewDataSource {

    private var galleryData = [
        GalleryItem(pic: "gjqt0", title: "少恭，悭臾"),
        GalleryItem(pic: "gjqt1", title: "屠苏，晴雪"),
        GalleryItem(pic: "gjqt2", title: "晴雪"),
        GalleryItem(pic: "gjqt3", title: "闻人羽，乐无异，阿阮，夏夷则"),
        GalleryItem(pic: "gjqt4", title: "悭臾"),
        GalleryItem(pic: "gjqt5", title: "阿阮")
    ]
    
    @IBOutlet weak var galleryCol: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        galleryCol.dataSource = self
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return galleryData.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = galleryCol.dequeueReusableCellWithReuseIdentifier("GalleryCell", forIndexPath: indexPath) as! GalleryCell
        cell.set(galleryData[indexPath.row], index: indexPath.row)
        return cell
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
