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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func setTimeAction(_ sender: Any) {
        second = 60;
    }

    @IBAction func runAction(_ sender: Any) {
        
    }
    
    @IBAction func resetAction(_ sender: Any) {
        
    }
}

