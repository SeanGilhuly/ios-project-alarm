//
//  SwitchTableViewCell.swift
//  Alarm
//
//  Created by Sean Gilhuly on 5/16/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {

    // MARK: - IBOutlets and Properties
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    weak var delegate: SwitchTableViewCellDelegate?
    
    
    // MARK: - IBActions
    
    
    @IBAction func switchValueChanged(sender: AnyObject) {
        delegate?.switchCellSwitchValueChanged(self)
    }

    
    func updateWithAlarm(alarm: Alarm) {
        timeLabel.text = alarm.fireTimeAsString
        nameLabel.text = alarm.name
        alarmSwitch.on = alarm.enabled
    }
}

protocol SwitchTableViewCellDelegate: class {
    func switchCellSwitchValueChanged(cell: SwitchTableViewCell)
}