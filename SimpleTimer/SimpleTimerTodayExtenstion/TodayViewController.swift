//
//  TodayViewController.swift
//  SimpleTimerTodayExtenstion
//
//  Created by 王 巍 on 14-8-2.
//  Copyright (c) 2014年 OneV's Den. All rights reserved.
//

import UIKit
import NotificationCenter
import SimpleTimerKit

class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var lblTimer: UILabel!
    
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.

        let userDefaults = NSUserDefaults(suiteName: "group.simpleTimerSharedDefaults")
        let leftTimeWhenQuit = userDefaults.integerForKey(keyLeftTime)
        let quitDate = userDefaults.integerForKey(keyQuitDate)
        
        let passedTimeFromQuit = NSDate().timeIntervalSinceDate(NSDate(timeIntervalSince1970: NSTimeInterval(quitDate)))
        
        let leftTime = leftTimeWhenQuit - Int(passedTimeFromQuit)
        
        if (leftTime > 0) {
            timer = Timer(timeInteral: NSTimeInterval(leftTime))
            timer.start(updateTick: {
                [weak self] leftTick in self!.updateLabel()
                }, stopHandler: {
                    [weak self] finished in self!.showOpenAppButton()
                })
        } else {
            showOpenAppButton()
        }
    }
    
    private func updateLabel() {
        lblTimer.text = timer.leftTimeString
    }
    
    private func showOpenAppButton() {
        lblTimer.text = "Finished"
        preferredContentSize = CGSizeMake(0, 100)
        
        let button = UIButton(frame: CGRectMake(0, 50, 50, 63))
        button.setTitle("Open", forState: UIControlState.Normal)
        button.addTarget(self, action: "buttonPressed:", forControlEvents: UIControlEvents.TouchUpInside)

        view.addSubview(button)
        
    }
    
    dynamic private func buttonPressed(sender: AnyObject!) {
        extensionContext.openURL(NSURL(string: "simpleTimer://finished"), completionHandler: nil)
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
