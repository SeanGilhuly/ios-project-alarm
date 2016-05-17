//
//  AlarmController.swift
//  Alarm
//
//  Created by Sean Gilhuly on 5/16/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class AlarmController {
    
    static let sharedController = AlarmController()
    
    var alarms: [Alarm] = []
    
    init() {
       self.alarms = []
       self.alarms = mockAlarms()
    }
    
    func addAlarm(fireTimeFromMidnight: NSTimeInterval, name: String) -> Alarm {
        // Create a new alarm from the Alarm initializer
        let alarm = Alarm(fireTimeFromMidnight: fireTimeFromMidnight, name: name)
        // Append the new alarm the array of alarms
        alarms.append(alarm)
        // Return the new alarm
        return alarm
    }
    
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
    
    func toggleEnabled(alarm: Alarm) {
        alarm.enabled = !alarm.enabled
    }
   
    func mockAlarms() -> [Alarm] {
        let alarm1 = Alarm(fireTimeFromMidnight: 30421, name: "Wake Up.  Long long long test", enabled: true)
        return [alarm1]
    }
  
}





