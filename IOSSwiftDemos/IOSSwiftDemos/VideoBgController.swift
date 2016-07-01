//
//  VideoBgController.swift
//  IOSSwiftDemos
//
//  Created by 123456 on 16/6/20.
//  Copyright © 2016年 xiyuan. All rights reserved.
//

import UIKit
import AVKit
import MediaPlayer

public enum ScalingMode {
    case Resize
    case ResizeAspect
    case ResizeAspectFill
}

class VideoBgController: UIViewController {

    private var player = AVPlayerViewController()
    
    var sound: Float = 0.0
    
    var playerFrame: CGRect = CGRect()
    
    var backgroundColor: UIColor = UIColor() {
        didSet {
            self.view.backgroundColor = backgroundColor
        }
    }
    
    var alpha: CGFloat = CGFloat() {
        didSet {
            self.player.view.alpha = alpha
        }
    }
    
    var alwaysRepeat: Bool = true {
        didSet {
            if alwaysRepeat {
                NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.playFinished), name: AVPlayerItemDidPlayToEndTimeNotification, object: nil)
            }
        }
    }
    
    var fillMode: ScalingMode = .ResizeAspectFill {
        didSet {
            switch fillMode {
            case .Resize:
                player.videoGravity = AVLayerVideoGravityResize
            case .ResizeAspect:
                player.videoGravity = AVLayerVideoGravityResizeAspect
            case .ResizeAspectFill:
                player.videoGravity = AVLayerVideoGravityResizeAspectFill
            }
        }
    }
    
    func playFinished() {
        player.player?.seekToTime(kCMTimeZero)
        player.player?.play()
    }
    
    func play(url: NSURL, startTime: Double, duration: Double){
        let videoCutter = VideoCutter()
        videoCutter.cropVideoWithUrl(videoUrl: url, startTime: CGFloat(startTime), duration: CGFloat(duration)) { (videoPath, error) -> Void in
            if let path = videoPath as NSURL? {
                let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                dispatch_async(dispatch_get_global_queue(priority, 0)) {
                    dispatch_async(dispatch_get_main_queue()) {
                        self.player.player = AVPlayer(URL: path)
                        self.player.player?.play()
                        self.player.player?.volume = self.sound
                    }
                }
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        player.view.userInteractionEnabled = false
        player.view.frame = playerFrame
        player.showsPlaybackControls = false
        view.addSubview(player.view)
        view.sendSubviewToBack(player.view)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}
