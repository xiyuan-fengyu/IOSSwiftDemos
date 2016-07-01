//
//  PlayMusicController.swift
//  IOSSwiftDemos
//
//  Created by 123456 on 16/6/20.
//  Copyright © 2016年 xiyuan. All rights reserved.
//

import UIKit
import AVFoundation

class PlayMusicController: UIViewController {

    @IBOutlet weak var playMusicBt: UIButton!
    
    @IBOutlet weak var musicSld: UISlider!
    
    @IBOutlet weak var timeLb: UILabel!
    
    private var isMusicSldDragging = false
    
    private var gradientLayer: CAGradientLayer!

    private var audioPlayer: AVAudioPlayer!
    
    private var timer: NSTimer!
    
    @IBAction func playMusicBtClick(sender: AnyObject) {
        newAudioPlayerIfNecessary()
        
        if audioPlayer != nil {
            if audioPlayer.playing {
                pause()
            }
            else {
                play()
            }
        }
    }
    
    private func play() {
        playMusicBt.setImage(UIImage(named: "icPauseMusic"), forState: UIControlState.Normal)
        audioPlayer.prepareToPlay()
        audioPlayer.play()
        
        newTimer()
    }
    
    private func pause() {
        playMusicBt.setImage(UIImage(named: "icPlayMusic"), forState: UIControlState.Normal)
        audioPlayer.pause()
        
        releaseTimer()
    }
    
    @IBAction func musicSldGragDown(sender: AnyObject) {
        isMusicSldDragging = true
    }
    
    @IBAction func musicSldDragUp(sender: AnyObject) {
        newAudioPlayerIfNecessary()
        if audioPlayer !== nil {
            audioPlayer.currentTime = audioPlayer.duration * Double(musicSld.value)
            play()
        }
        isMusicSldDragging = false
    }
    
    @IBAction func musicSldTouchCancle(sender: AnyObject) {
        isMusicSldDragging = false
    }
    
    
    private func newAudioPlayerIfNecessary() {
        if audioPlayer === nil {
            if let audioUrl = NSBundle.mainBundle().URLForResource("水龙吟", withExtension: "mp3") {
                do {
                    try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
                    try AVAudioSession.sharedInstance().setActive(true)
                    try audioPlayer = AVAudioPlayer(contentsOfURL: audioUrl)
                }
                catch let audioError as NSError {
                    print(audioError)
                }
            }
        }
    }
    
    func updateUi() {
        if !audioPlayer.playing {
            pause()
        }
        
        if !isMusicSldDragging {
            musicSld.value = Float(audioPlayer.currentTime / audioPlayer.duration)
        }
        timeLb.text = audioPlayer.currentTime.timeHMS
    }
    
    private func newTimer() {
        updateUi()
        
        releaseTimer()
        timer = NSTimer.scheduledTimerWithTimeInterval(1 / 45.0, target: self, selector: #selector(self.updateUi), userInfo: nil, repeats: true)
    }
    
    private func releaseTimer() {
        if timer !== nil {
            timer.invalidate()
            timer = nil
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        releaseTimer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //自定义Slider的bar样式
        if let sliderBar = UIImage(named: "icSliderBar") {
            musicSld.setThumbImage(sliderBar, forState: UIControlState.Normal)
            musicSld.setThumbImage(sliderBar, forState: UIControlState.Highlighted)
        }
        
        //设置timeLb的字体为等宽字体，这样在显示时间的时候不会出现抖动
        timeLb.font = UIFont(name: "NotCourierSans-Bold", size: 17)!
        
        //设置颜色渐变层
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.frame
        let color1 = UIColor(white: 0.5, alpha: 0.2).CGColor as CGColorRef
        let color2 = UIColor(red: 1.0, green: 0, blue: 0, alpha: 0.4).CGColor as CGColorRef
        let color3 = UIColor(red: 0, green: 1, blue: 0, alpha: 0.3).CGColor as CGColorRef
        let color4 = UIColor(red: 0, green: 0, blue: 1, alpha: 0.3).CGColor as CGColorRef
        let color5 = UIColor(white: 0.4, alpha: 0.2).CGColor as CGColorRef
        
        gradientLayer.colors = [color1, color2, color3, color4, color5]
        gradientLayer.locations = [0.10, 0.30, 0.50, 0.70, 0.90]
        gradientLayer.startPoint = CGPointMake(0, 0)
        gradientLayer.endPoint = CGPointMake(1, 1)
        self.view.layer.addSublayer(gradientLayer)
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
