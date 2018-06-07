//
//  ViewController.swift
//  Timer
//
//  Created by hetao on 2018/6/6.
//  Copyright © 2018 hetao. All rights reserved.
//

import UIKit
import UserNotifications

// TODO:
/*
 [] 归零持久化
 [] 暂停状态持久化
 [] App开启时的通知
 [] 通知声音
 [] UI
 */

class ViewController: UIViewController {
    // UI
    @IBOutlet weak var timerLb: UILabel!
    @IBOutlet weak var controlView: UIView!
    @IBOutlet weak var switchBtn: UIButton!
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var timeSlier: UISlider!

    var showSecond: NSInteger!
    var timer: Timer!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(timerAction),
                                     userInfo: nil,
                                     repeats:true)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Temp
    @IBAction func start(_ sender: UIButton) {
        showSecond = 10
        setTimerRunning(true)
    }
    
    // Slider
    @IBAction func timeSliderBegin(_ slider: UISlider) {
        setTimerRunning(false)
        controlView.isHidden = true
    }
    
    @IBAction func timeSlidering(_ slider: UISlider) {
        let second = (NSInteger)(slider.value) * 60
        updateShowTime(second)
    }
    
    @IBAction func timeSliderDone(_ slider: UISlider) {
        showSecond = (NSInteger)(slider.value) * 60
        if (showSecond > 0) {
            setTimerRunning(true)
            controlView.isHidden = false
        } else {
            updateShowTime(showSecond)
        }
    }

    @IBAction func runAction(_ sender: UIButton) {
        setTimerRunning(sender.isSelected)
    }
    
    @IBAction func resetAction(_ sender: UIButton) {
        self.reset()
    }
    
    // 设置Timer 暂停/继续
    func setTimerRunning(_ isRunning: Bool) {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.isRunning = isRunning
        switchBtn.isSelected = !isRunning
        resetBtn.isEnabled = !isRunning
        if (isRunning) {
            //
            let delegate = UIApplication.shared.delegate as! AppDelegate
            delegate.saveDateAfterSecend(showSecond)
            // 继续
            timer.fireDate = Date.distantPast
        } else {
            // 暂停
            timer.fireDate = Date.distantFuture
            //
            let center = UNUserNotificationCenter.current()
            center.removeAllPendingNotificationRequests()
        }
    }
    
    func reset() {
        // 计时器暂停
        setTimerRunning(false)
        //
        showSecond = 0
        updateShowTime(showSecond)
        //
        controlView.isHidden = true
    }
    
    @objc func timerAction(_ sender: Any) {

        let delegate = UIApplication.shared.delegate as! AppDelegate
        showSecond = delegate.getSecend()
        updateShowTime(showSecond)
        self.timeSlier.value = Float(showSecond)/60.0

        if (showSecond <= 0) {
            self.reset()
        } else {
            controlView.isHidden = false
        }
    }
    
    func updateShowTime(_ secondArg: NSInteger) {
        print("showSecond:\(showSecond!)")
        let time = transitionTime(secondArg)
        timerLb.text = time
        print("time:\(time)")
    }
    
    func transitionTime(_ secondArg: NSInteger) -> String{
        var second = secondArg
        if (secondArg < 0){
            second = -secondArg
        }
        let hour = second / 3600;
        let hour_str = hour > 0 ? "\(hour)" : ""
        let minute = (second % 3600) / 60;
        let minute_str = minute >= 10 ? "\(minute)" : "0\(minute)"
        let s = (second % 60);
        let s_str = s >= 10 ? "\(s)" : "0\(s)"
        
        let ms = minute_str + ":" + s_str;
        let time = hour > 0 ? (hour_str + ":" + ms) : ms
        if (secondArg < 0){
            return ("-" + time)
        }
        return time
    }
}

