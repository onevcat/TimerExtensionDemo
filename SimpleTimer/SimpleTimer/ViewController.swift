//
//  ViewController.swift
//  SimpleTimer
//
//  Created by 王 巍 on 14-8-1.
//  Copyright (c) 2014年 OneV's Den. All rights reserved.
//

import UIKit

let defaultTimeInterval: NSTimeInterval = 1 * 60

class ViewController: UIViewController {
                            
    @IBOutlet weak var lblTimer: UILabel!
    
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateLabel() {
        lblTimer.text = timer.leftTimeString
    }

    @IBAction func btnStartPressed(sender: AnyObject) {
        if timer == nil {
            timer = Timer(timeInteral: defaultTimeInterval)
        }
        
        let (started, error) = timer.start(updateTick: {
            [weak self] leftTick in self!.updateLabel()
            }, stopHandler: {
                finished in println(finished)
            })
        
        if started {
            updateLabel()
        } else {
            if let err = error {
                println("error: \(err.code)")
            }
        }
    }
    
    @IBAction func btnStopPressed(sender: AnyObject) {
        
    }

}

