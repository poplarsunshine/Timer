//
//  ViewController.swift
//  Timer
//
//  Created by hetao on 2018/6/6.
//  Copyright © 2018 hetao. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    // UI
    @IBOutlet weak var timerLb: UILabel!
    @IBOutlet weak var controlView: UIView!
    @IBOutlet weak var switchBtn: UIButton!
    @IBOutlet weak var resetBtn: UIButton!

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
    
    @IBAction func setTimeAction(_ sender: Any) {
        showSecond = 10
        setTimerRunning(true)
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
        timerLb.text = ""
        //
        controlView.isHidden = true
    }
    
    @objc func timerAction(_ sender: Any) {

        let delegate = UIApplication.shared.delegate as! AppDelegate
        showSecond = delegate.getSecend()
        if (showSecond <= 0) {
            self.reset()
        } else {
            timerLb.text = "\(showSecond)"
            
            controlView.isHidden = false
        }
    }
}

