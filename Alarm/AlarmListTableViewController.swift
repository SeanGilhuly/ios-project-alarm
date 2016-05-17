//
//  AlarmListTableViewController.swift
//  Alarm
//
//  Created by Sean Gilhuly on 5/16/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class AlarmListTableViewController: UITableViewController, SwitchTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AlarmController.sharedController.alarms.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("alarmCell", forIndexPath: indexPath) as? SwitchTableViewCell ?? SwitchTableViewCell()

        // Configure the cell... The cell is called "alarm", now pull the cell out of the row
        let alarm = AlarmController.sharedController.alarms[indexPath.row]
        cell.updateWithAlarm(alarm)
        cell.delegate = self


        return cell
    }


    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            // Find the cell for the row that you will be deleting
            // Set that cell to "alarm"
            let alarm = AlarmController.sharedController.alarms[indexPath.row]
            
            //Delete the row.  Call it on the "Delete Alarm" function
            AlarmController.sharedController.deleteAlarm(alarm)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    
    func switchCellSwitchValueChanged(cell: SwitchTableViewCell) {
        
        guard let indexPath = tableView.indexPathForCell(cell) else {
            return
        }
        let alarm = AlarmController.sharedController.alarms[indexPath.row]
        AlarmController.sharedController.toggleEnabled(alarm)
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toAlarmDetail" {
            let alarmDetailTableViewController = segue.destinationViewController as? AlarmDetailTableViewController
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let alarm = AlarmController.sharedController.alarms[indexPath.row]
            alarmDetailTableViewController?.alarm = alarm
        }
    }
    
}