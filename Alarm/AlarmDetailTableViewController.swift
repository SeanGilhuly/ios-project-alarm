//
//  AlarmDetailTableViewController.swift
//  Alarm
//
//  Created by Sean Gilhuly on 5/16/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var alarmDatePicker: UIDatePicker!
    @IBOutlet weak var alarmTitleTextField: UITextField!
    @IBOutlet weak var enableButton: UIButton!
    
    //Add an alarm property of type Alarm?
    var alarm: Alarm?
    
    override func viewDidLoad() {
        //unwrap self.alarm
        //You only want to update an alarm, if you have an alarm
        if let alarm = alarm {
        //Display an alarm
            updateWithAlarm(alarm)
        }
        //Call setupView() to set up the button state
        setupView()
    }
    
    func setupView() {
        
        if alarm == nil {
            enableButton.hidden = true
        } else {
            enableButton.hidden = false
            if alarm?.enabled == true {
                enableButton.setTitle("Disable", forState: .Normal)
                enableButton.setTitleColor(.whiteColor(), forState: .Normal)
                enableButton.backgroundColor = .redColor()
            } else {
                enableButton.setTitle("Enable", forState: .Normal)
                enableButton.setTitleColor(.blueColor(), forState: .Normal)
                enableButton.backgroundColor = .grayColor()
            }
        }
    }
    

    func updateWithAlarm(alarm: Alarm) {
        
        guard let thisMorningAtMidnight = DateHelper.thisMorningAtMidnight else {
            return
        }
        //Update the date picker
        alarmDatePicker.setDate(NSDate(timeInterval: alarm.fireTimeFromMidnight, sinceDate: thisMorningAtMidnight), animated: false)
        //Update alarm text title field
        alarmTitleTextField.text = alarm.name
        //Update alarm title
        self.title = alarm.name
    }
    
    // MARK: - IBActions
    @IBAction func enableButtonTapped(sender: AnyObject) {
        guard let alarm = alarm else {
            return
        }
        AlarmController.sharedController.toggleEnabled(alarm)
        setupView()
    }
   
    @IBAction func saveButtonTapped(sender: AnyObject) {
        // If alarm title has entered text, and a date as been selected, make it equal to "title"
        // This is what you will need to populate the information on the next page
        guard let title = alarmTitleTextField.text,
            thisMorningAtMidnight = DateHelper.thisMorningAtMidnight else {return}
        let timeIntervalSinceMidnight = alarmDatePicker.date.timeIntervalSinceDate(thisMorningAtMidnight)
        //Unwrap self.alarm
        //If there is an alarm (alarm = alarm), then pass in the information
        if let alarm = alarm {   // If an alarm exists
            AlarmController.sharedController.updateAlarm(alarm, fireTimeFromMidnight: timeIntervalSinceMidnight, name: title)
        } else {
        // If there is not an alarm, then add a new one
            let alarm = AlarmController.sharedController.addAlarm(timeIntervalSinceMidnight, name: title)
            self.alarm = alarm
        }
        self.navigationController?.popViewControllerAnimated(true)
    }
}
