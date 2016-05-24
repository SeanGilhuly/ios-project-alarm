//
//  AlarmDetailTableViewController.swift
//  Alarm
//
//  Created by Sean Gilhuly on 5/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var button: UIButton!
    
    var alarm: Alarm?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let alarm = alarm {
            updateWithAlarm(alarm)
        }
        setupView()
    }

    
    func setupView() {
        if alarm == nil {
            button.hidden = true
        } else {
            button.hidden = false
            if alarm?.enabled == true {
                button.setTitle("Disable", forState: .Normal)
                button.setTitleColor(.whiteColor(), forState: .Normal)
                button.backgroundColor = .redColor()
            } else {
                button.setTitle("Enable", forState: .Normal)
                button.setTitleColor(.blueColor(), forState: .Normal)
                button.backgroundColor = .grayColor()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBActions
    
    @IBAction func enableButtonTapped(sender: AnyObject) {
        
    }

    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        guard let title = textField.text,
            thisMorningAtMidnight = DateHelper.thisMorningAtMidnight else {return}
        let timeIntervalSinceMidnight = datePicker.date.timeIntervalSinceDate(thisMorningAtMidnight)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: Functions
    
    func updateWithAlarm(alarm: Alarm) {
        guard let thisMorningAtMidnight = DateHelper.thisMorningAtMidnight else { return }
        datePicker.setDate(NSDate(timeInterval: alarm.fireTimeFromMidnight, sinceDate: thisMorningAtMidnight), animated: false)
        textField.text = alarm.name
        self.title = alarm.name
    }
}
