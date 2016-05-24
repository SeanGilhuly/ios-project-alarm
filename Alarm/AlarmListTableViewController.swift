//
//  AlarmListTableViewController.swift
//  Alarm
//
//  Created by Sean Gilhuly on 5/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class AlarmListTableViewController: UITableViewController, SwitchTableViewCellDelegate, AlarmScheduler {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    func switchCellSwitchValueChanged(cell: SwitchTableViewCell) {
        guard let alarm = cell.alarm, indexPath = tableView.indexPathForCell(cell) else { return }
        AlarmController.sharedController.toggleEnabled(alarm)
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        
        if alarm.enabled {
            scheduleLocalNotification(alarm)
        } else {
            cancelLocalNotification(alarm)
        }
    }
    
    
    // MARK: - Table view data source


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AlarmController.sharedController.alarms.count
    }

 
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("alarmCell", forIndexPath: indexPath) as? SwitchTableViewCell

        let index = AlarmController.sharedController.alarms[indexPath.row]
        cell?.updateWithAlarm(index)

        return cell ?? SwitchTableViewCell()
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            // Delete the row from the data source
            let deletedAlarm = AlarmController.sharedController.alarms[indexPath.row]
            AlarmController.sharedController.deleteAlarm(deletedAlarm)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }

    // MARK: - Navigation - Prepare for Segue

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            if segue.identifier == "toEditAlarm" {
                if let alarmDetailTableViewController = segue.destinationViewController as? AlarmDetailTableViewController {
                    if let alarmCell = sender as? UITableViewCell {
                        if let indexPath = tableView.indexPathForCell(alarmCell) {
                            alarmDetailTableViewController.alarm = AlarmController.sharedController.alarms[indexPath.row]
                    }
                }
            }
        }
    }
}
