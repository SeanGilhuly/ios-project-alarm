//
//  AlarmController.swift
//  Alarm
//
//  Created by Sean Gilhuly on 5/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

class AlarmController {
    
    static let sharedController = AlarmController()
    
    var alarms: [Alarm] = []
    
    init() {
        self.alarms = mockAlarms
    }
    
    // MARK: - Functions
    
    func addAlarm(fireTimeFromMidnight: NSTimeInterval, name: String) {
        let alarm = Alarm(fireTimeFromMidnight: fireTimeFromMidnight, name: name)
        alarms.append(alarm)
    }
    
    func updateAlarm(alarm: Alarm, fireTimeFromMidnight: NSTimeInterval, name: String) {
        alarm.fireTimeFromMidnight = fireTimeFromMidnight
        alarm.name = name
    }
    
    func deleteAlarm(alarm: Alarm) {
        guard let index = alarms.indexOf(alarm) else { return }
        alarms.removeAtIndex(index)
    }
    
    func toggleEnabled(alarm: Alarm) {
        alarm.enabled = !alarm.enabled
    }
    
    // MARK: - Mock data
    
    var mockAlarms:[Alarm] {
        let alarm1 = Alarm(fireTimeFromMidnight: 12345, name: "Test Alarm 1")
        let alarm2 = Alarm(fireTimeFromMidnight: 65432, name: "Test Alarm 2")
        let alarm3 = Alarm(fireTimeFromMidnight: 34521, name: "Test Alarm 3")
        
        return [alarm1, alarm2, alarm3]
    }
    
}