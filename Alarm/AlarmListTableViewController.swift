//
//  AlarmListTableViewController.swift
//  Alarm
//
//  Created by Sean Gilhuly on 5/16/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class AlarmListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //Reload the data on the page
        tableView.reloadData()
    }

    // MARK: - Table view data source


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Count the number of strings in the alarm array
        return AlarmController.sharedController.alarms.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("alarmCell", forIndexPath: indexPath) as? SwitchTableViewCell ?? SwitchTableViewCell()
        // as? = because you need to access the Switch
        //"??" - nil collolensce...  if the left is wrong, go right

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
    
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Check to see if they clicked on the specific cell
        if segue.identifier == "toAlarmDetail" {
            //If so, find the destination to where they are going
            if let alarmDetailTableViewController = segue.destinationViewController as? AlarmDetailTableViewController {
                //
                if let alarmCell = sender as? UITableViewCell {
                    if let indexPath = tableView.indexPathForCell(alarmCell) {
                    alarmDetailTableViewController.alarm = AlarmController.sharedController.alarms[indexPath.row]
                    }
                }
            }
        }
    }
}




extension AlarmListTableViewController: SwitchTableViewCellDelegate {
    func switchCellSwitchValueChanged(cell: SwitchTableViewCell) {
    // set a property to return a the specific cell to switch
    guard let indexPath = tableView.indexPathForCell(cell) else { return }
    //Find the specific "alarm" row you want
    let alarm = AlarmController.sharedController.alarms[indexPath.row]
    //Enable the specific alarm row you found
    AlarmController.sharedController.toggleEnabled(alarm)
    //Reload the data so it shows the switch as on
    tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
}
}