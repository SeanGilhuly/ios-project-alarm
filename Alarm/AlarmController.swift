//
//  AlarmController.swift
//  Alarm
//
//  Created by Sean Gilhuly on 5/16/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class AlarmController {
    
    // This allows you to access the information
    static let sharedController = AlarmController()
    
    //An alarms array property with an empty array as a default value
    var alarms: [Alarm] = []
    
    //You have to initalize the data 
    init() {
        alarms = []
        alarms = mockAlarm
    }
    // Make a computed property that returns a Alarm String
    var mockAlarm: [Alarm] {
        let alarm1 = Alarm(fireTimeFromMidnight: 5, name: "Sean")
        let alarm2 = Alarm(fireTimeFromMidnight: 10, name: "Nathan")
        //Return the alarms you just created
        return [alarm1, alarm2]
    }
    
    func addAlarm(fireTimeFromMidnight: NSTimeInterval, name: String) -> Alarm {
        // Create a new alarm from the Alarm initializer
        let alarm = Alarm(fireTimeFromMidnight: fireTimeFromMidnight, name: name)
        // Append (add) the new alarm the array of alarms
        alarms.append(alarm)
        // Return the new alarm
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
    }
    

    // Change the alarm's underlying enabled property
    func toggleEnabled(alarm: Alarm) {
        //"!" = not
        alarm.enabled = !alarm.enabled
                            // means (alarm.enabled != alarm.enabled)
    }
}





