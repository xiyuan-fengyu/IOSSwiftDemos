//
//  PhotoViewerController.swift
//  IOSSwiftDemos
//
//  Created by 123456 on 16/6/20.
//  Copyright © 2016年 xiyuan. All rights reserved.
//

import UIKit

class PhotoViewerController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var photoSV: UIScrollView!
    
    private var photo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        photoSV.frame = self.view.frame
        photoSV.delegate = self
        photoSV.maximumZoomScale = 3.0
        photoSV.minimumZoomScale = 1
        
        addPhoto()
    }

    private func addPhoto() {
        if let tempImg = UIImage(named: "videoScreenshot08") {
            let svW = Double(photoSV.frame.width)
            let svH = Double(photoSV.frame.height)
            let photoW = Double(tempImg.size.width)
            let photoH = Double(tempImg.size.height)
            
            if svW / svH > photoW / photoH {
                let photoRealW = svH / photoH * photoW
                let x = CGFloat((svW - photoRealW) / 2)
                photo = UIImageView(frame: CGRect(x: 0, y: 0.0, width: photoRealW, height: svH))
                photoSV.contentSize = CGSize(width: photoRealW, height: svH)
                photoSV.contentInset = UIEdgeInsetsMake(0, x, 0, x)
            }
            else {
                let photoRealH = svW / photoW * photoH
                let y = CGFloat((svH - photoRealH) / 2)
                photo = UIImageView(frame: CGRect(x: 0, y: 0, width: svW, height: photoRealH))
                photoSV.contentSize = CGSize(width: svW, height: photoRealH)
                photoSV.contentInset = UIEdgeInsetsMake(y, 0, y, 0)
            }
            photo.image = tempImg
            photoSV.addSubview(photo)
            
            photo.userInteractionEnabled = true
            let gesture = UITapGestureRecognizer(target: self, action: #selector(self.onPhotoDoubleClick))
            gesture.numberOfTapsRequired = 2
            photo.addGestureRecognizer(gesture)
        }
    }
    
    func onPhotoDoubleClick() {
        let midScale = (photoSV.maximumZoomScale + photoSV.minimumZoomScale) / 2
        let curScale = photoSV.zoomScale
        if curScale >= photoSV.minimumZoomScale && curScale < midScale {
            photoSV.zoomScale = midScale
        }
        else if curScale >= midScale && curScale < photoSV.maximumZoomScale {
            photoSV.zoomScale = photoSV.maximumZoomScale
        }
        else {
            photoSV.zoomScale = photoSV.minimumZoomScale
        }
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return photo
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
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
