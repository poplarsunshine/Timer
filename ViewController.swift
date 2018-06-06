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
        second = getSecend()

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
        
        saveSecend(second)
        
        timerLb.text = "\(second)"
    }
    
    // Time IO
    func saveSecend(_ aSecend: NSInteger) {
        let tSecond = (TimeInterval)(aSecend)
        let date = Date(timeIntervalSinceNow: tSecond)
        
        // Formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss zz"
        let dateString = dateFormatter.string(from: date)
        // 持久化
        let defaultStand = UserDefaults.standard
        defaultStand.set(dateString, forKey: "TimerDateKey")
    }
    
    func getSecend() -> NSInteger{
        let defaultStand = UserDefaults.standard
        let dateString = defaultStand.string(forKey: "TimerDateKey")
        // Formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss zz"
        let date = dateFormatter.date(from: dateString!)
        let aSecend = date?.timeIntervalSinceNow;
        return (NSInteger)(aSecend!);
    }
}

