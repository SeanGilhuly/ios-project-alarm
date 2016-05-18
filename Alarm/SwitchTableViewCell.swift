//
//  SwitchTableViewCell.swift
//  Alarm
//
//  Created by Sean Gilhuly on 5/16/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

// Views should only get up the view and do no computing

import UIKit

class SwitchTableViewCell: UITableViewCell {

    // MARK: - IBOutlets and Properties
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    // Must add this to have access to the delegate protocol
    //"weak" deals with memory
    //If you don't add "weak", apple automatically adds "strong" as inferred
    weak var delegate: SwitchTableViewCellDelegate?
    
    
    // MARK: - IBActions
    
    //Check if a delegate is assigned, and if so, call the delegate protocol function
    @IBAction func switchValueChanged(sender: AnyObject) {
        delegate?.switchCellSwitchValueChanged(self)
    }

    // Update the labels to the time and name of the alarm
    // Update the alarmSwitch to "on" / enabled
    func updateWithAlarm(alarm: Alarm) {
        timeLabel.text = alarm.fireTimeAsString
        nameLabel.text = alarm.name
        alarmSwitch.on = alarm.enabled
    }
}


protocol SwitchTableViewCellDelegate: class {
    func switchCellSwitchValueChanged(cell: SwitchTableViewCell)
}