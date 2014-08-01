//
//  ViewController.swift
//  SimpleTimer
//
//  Created by 王 巍 on 14-8-1.
//  Copyright (c) 2014年 OneV's Den. All rights reserved.
//

import UIKit

let defaultTimeInterval: NSTimeInterval = 5

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
    
    private func updateLabel() {
        lblTimer.text = timer.leftTimeString
    }
    
    private func showFinishAlert(# finished: Bool) {
        let ac = UIAlertController(title: nil , message: finished ? "Finished" : "Stopped", preferredStyle: .Alert)
        ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: {[weak ac] action in ac!.dismissViewControllerAnimated(true, completion: nil)}))
            
        presentViewController(ac, animated: true, completion: nil)
    }

    @IBAction func btnStartPressed(sender: AnyObject) {
        if timer == nil {
            timer = Timer(timeInteral: defaultTimeInterval)
        }
        
        let (started, error) = timer.start(updateTick: {
                [weak self] leftTick in self!.updateLabel()
            }, stopHandler: {
                [weak self] finished in
                self!.showFinishAlert(finished: finished)
                self!.timer = nil
            })
        
        if started {
            updateLabel()
        } else {
            if let realError = error {
                println("error: \(realError.code)")
            }
        }
    }
    
    @IBAction func btnStopPressed(sender: AnyObject) {
        if let realTimer = timer {
            let (stopped, error) = realTimer.stop()
            if !stopped {
                if let realError = error {
                    println("error: \(realError.code)")
                }
            }
        }
    }

}

