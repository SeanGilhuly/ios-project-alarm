//
//  AlarmController.swift
//  Alarm
//
//  Created by Sean Gilhuly on 5/16/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class AlarmController {
    
    private let AlarmsKey = "alarms"
    
    
    // This allows you to access the information
    static let sharedController = AlarmController()
    
    //An alarms array property with an empty array as a default value
    var alarms: [Alarm] = []
    
    
    init() {
        loadFromPersistentStorage()
    }
// Make a computed property that returns a Alarm String
//    var mockAlarm: [Alarm] {
//        let alarm1 = Alarm(fireTimeFromMidnight: 5, name: "Sean")
//        let alarm2 = Alarm(fireTimeFromMidnight: 10, name: "Nathan")
//        //Return the alarms you just created
//        return [alarm1, alarm2]
//    }
    
    func addAlarm(fireTimeFromMidnight: NSTimeInterval, name: String) -> Alarm {
        // Create a new alarm from the Alarm initializer
        let alarm = Alarm(fireTimeFromMidnight: fireTimeFromMidnight, name: name)
        // Append (add) the new alarm the array of alarms
        alarms.append(alarm)
        // Return the new alarm
       
        // Save the current alarms array to a file using NSKeyedArchiver
        saveToPersistentStorage()
        
        return alarm
    }
    // Pass in the "alarm" you want to change in the parameter, along with the firetime and name
    func updateAlarm(alarm: Alarm, fireTimeFromMidnight: NSTimeInterval, name: String) {
        //Update an existing alarms time
        alarm.fireTimeFromMidnight = fireTimeFromMidnight
        //Update an exisiting alarms name
        alarm.name = name
    }
    
    func deleteAlarm(alarm: Alarm) {
        // Find the specific index of Alarm that you want to delete
        guard let index = alarms.indexOf(alarm) else {
            return
        }
        //Once you find that specific index, remove it from index
        alarms.removeAtIndex(index)
        saveToPersistentStorage()
    }
    

    // Change the alarm's underlying enabled property
    func toggleEnabled(alarm: Alarm) {
        //"!" = not
        alarm.enabled = !alarm.enabled
                            // means (alarm.enabled != alarm.enabled)
    }
    
    
    func saveToPersistentStorage() {
        NSKeyedArchiver.archiveRootObject(self.alarms, toFile: filePath(AlarmsKey))
    }
    
    
    func loadFromPersistentStorage() {
        NSKeyedUnarchiver.unarchiveObjectWithFile(self.filePath(AlarmsKey))
        guard let alarms = NSKeyedUnarchiver.unarchiveObjectWithFile(self.filePath(AlarmsKey)) as? [Alarm] else {
            return
        }
        self.alarms = alarms
    }
    
    func filePath(key: String) -> String {
        let directorySearchResults = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory,NSSearchPathDomainMask.AllDomainsMask, true)
        let documentsPath: AnyObject = directorySearchResults[0]
        let entriesPath = documentsPath.stringByAppendingString("/\(key).plist")
        
        return entriesPath
    }
}

protocol AlarmScheduler {
    func scheduleLocalNotification(alarm: Alarm)
    func cancelLocalNotification(alarm: Alarm)
}

extension AlarmScheduler {
    func scheduleLocalNotification(alarm: Alarm) {
        // Create an instance of UILocalNotification
        let localNotification = UILocalNotification()
        //
        localNotification.category = alarm.uuid
        localNotification.alertTitle = "Time's up!"
        localNotification.alertBody = "Your alarm is done"
        localNotification.fireDate = alarm.fireDate
        localNotification.repeatInterval = .Day
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }
    
    func cancelLocalNotification(alarm: Alarm) {
        // Get all of the application's scheduled notifications
        guard let scheduledNotifications = UIApplication.sharedApplication().scheduledLocalNotifications else {return}
        // Cancel the local notifications whose category matches the alarm 
        for notification in scheduledNotifications {
            if notification.category ?? "" == alarm.uuid {
                UIApplication.sharedApplication().cancelLocalNotification(notification)
            }
        }
    }
}


