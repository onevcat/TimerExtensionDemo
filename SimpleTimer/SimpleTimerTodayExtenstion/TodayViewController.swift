//
//  TodayViewController.swift
//  SimpleTimerTodayExtenstion
//
//  Created by 王 巍 on 14-8-2.
//  Copyright (c) 2014年 OneV's Den. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController {
        
    @IBOutlet weak var lblTImer: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.

        let userDefaults = NSUserDefaults(suiteName: "group.simpleTimerSharedDefaults")
        let leftTimeWhenQuit = userDefaults.integerForKey("com.onevcat.simpleTimer.lefttime")
        let quitDate = userDefaults.integerForKey("com.onevcat.simpleTimer.quitdate")
        
        let passedTimeFromQuit = NSDate().timeIntervalSinceDate(NSDate(timeIntervalSince1970: NSTimeInterval(quitDate)))
        
        let leftTime = leftTimeWhenQuit - Int(passedTimeFromQuit)
        
        lblTImer.text = "\(leftTime)"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Perform any setup necessary in order to update the view.

        // If an error is encoutered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    
}
