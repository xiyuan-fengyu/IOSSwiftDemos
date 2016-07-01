//
//  TimerUtil.swift
//  IOSSwiftDemos
//
//  Created by 123456 on 16/6/17.
//  Copyright © 2016年 xiyuan. All rights reserved.
//

import Foundation

protocol OnTimeChanged {

    func onTimeChanged(time: String)
}

class Timer {
    
    private let onTimeChanged: OnTimeChanged
    
    private let timeFormat: String
    
    private var _curTime: Float = 0.0
    
    private var isPause: Bool = false
    
    private var isDestory: Bool = false
    
    var curTime: String {
        get {
            return String(format: timeFormat, _curTime)
        }
    }
    
    private var timeThread: NSThread?
    
    init(onTimeChanged: OnTimeChanged, timeFormat: String = "%.1f") {
        self.onTimeChanged = onTimeChanged
        self.timeFormat = timeFormat
    }
    
    func start() {
        isPause = false
        if self.timeThread == nil {
            self.timeThread = NSThread(target: self, selector: #selector(Timer.timer), object: nil)
            self.timeThread?.start()
        }
    }
    
    @objc private func timer() {
        while !isDestory {
            usleep(100000)
            if(!isPause) {
                _curTime += 0.1
                mainThreadCallback()
            }
        }
    }
    
    func reset() {
        _curTime = 0.0
        isPause = true
        mainThreadCallback()
    }
    
    func mainThreadCallback() {
        dispatch_async(dispatch_get_main_queue(), {
            self.onTimeChanged.onTimeChanged(self.curTime)
        })
    }
    
    func pause() {
        isPause = true
    }
    
    func destory() {
        isPause = true
        isDestory = true
        self.timeThread = nil
    }
    
}