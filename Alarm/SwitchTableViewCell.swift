//
//  SwitchTableViewCell.swift
//  Alarm
//
//  Created by Sean Gilhuly on 5/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    var alarm: Alarm?
    
    weak var delegate: SwitchTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - IBActions
    
    @IBAction func switchValueChanged(sender: AnyObject) {
        // check if a delegate is assigned, and if so, call the delegate protocol function
        delegate?.switchCellSwitchValueChanged(self)
    }
    
    
    // MARK: - Functions
    
    func updateWithAlarm(alarm: Alarm) {
        self.alarm = alarm
        timeLabel.text = alarm.fireTimeAsString
        nameLabel.text = alarm.name
        alarmSwitch.on = alarm.enabled
    }
}

protocol SwitchTableViewCellDelegate: class {
    func switchCellSwitchValueChanged(cell: SwitchTableViewCell)
}







