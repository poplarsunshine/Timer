//
//  ViewController.swift
//  Timer
//
//  Created by hetao on 2018/6/6.
//  Copyright © 2018 hetao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // UI
    @IBOutlet weak var timerLb: UILabel!
    @IBOutlet weak var controlView: UIView!
    @IBOutlet weak var switchBtn: UIButton!
    @IBOutlet weak var resetBtn: UIButton!

    var second: NSInteger!
    var timer: Timer!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        second = 60;

        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(timerAction),
                                     userInfo: nil,
                                     repeats:true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func setTimeAction(_ sender: Any) {
        second = 60;

        // 计时器继续
        timer.fireDate = Date.distantPast
    }

    @IBAction func runAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        timer.fireDate = sender.isSelected ? Date.distantFuture : Date.distantPast
    }
    
    @IBAction func resetAction(_ sender: UIButton) {
        // 计时器暂停
        timer.fireDate = Date.distantFuture
        timerLb.text = ""
    }
    
    @objc func timerAction(_ sender: Any) {
        second = second - 1
        print("Second: \(second)")
        timerLb.text = "\(second)"
    }
}

