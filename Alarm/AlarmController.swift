//
//  AlarmController.swift
//  Alarm
//
//  Created by Sean Gilhuly on 5/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import UIKit

class AlarmController {
    
    private let kAlarms = "alarmns"
    
    static let sharedController = AlarmController()
    
    var alarms: [Alarm] = []
    
    init() {
        self.alarms = mockAlarms
        loadFromPersistentStorage()
    }
    
    // MARK: - Functions
    
    func addAlarm(fireTimeFromMidnight: NSTimeInterval, name: String) -> Alarm  {
        let alarm = Alarm(fireTimeFromMidnight: fireTimeFromMidnight, name: name)
        alarms.append(alarm)
        saveToPersistentStorage()
        return alarm
    }
    
    func updateAlarm(alarm: Alarm, fireTimeFromMidnight: NSTimeInterval, name: String) {
        alarm.fireTimeFromMidnight = fireTimeFromMidnight
        alarm.name = name
        saveToPersistentStorage()
    }
    
    func deleteAlarm(alarm: Alarm) {
        guard let index = alarms.indexOf(alarm) else { return }
        alarms.removeAtIndex(index)
        saveToPersistentStorage()
    }
    
    func toggleEnabled(alarm: Alarm) {
        alarm.enabled = !alarm.enabled
        saveToPersistentStorage()
    }
    
    // MARK: - Mock data
    
    var mockAlarms:[Alarm] {
        let alarm1 = Alarm(fireTimeFromMidnight: 12345, name: "Test Alarm 1")
        let alarm2 = Alarm(fireTimeFromMidnight: 65432, name: "Test Alarm 2")
        let alarm3 = Alarm(fireTimeFromMidnight: 34521, name: "Test Alarm 3")
        
        return [alarm1, alarm2, alarm3]
    }
    
    func saveToPersistentStorage() {
        NSKeyedArchiver.archiveRootObject(self.alarms, toFile: filePath(kAlarms))
    }
    
    func loadFromPersistentStorage() {
        guard let alarm = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath(kAlarms)) as? [Alarm] else { return }
        self.alarms = alarm
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
        let localNotification = UILocalNotification()
        localNotification.alertTitle = "Hello"
        localNotification.alertBody = "How are you doing today?"
        localNotification.fireDate = alarm.fireDate
        localNotification.category = alarm.uuid
        
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
        
    }
    
    func cancelLocalNotification(alarm: Alarm) {
        guard let allNotifications = UIApplication.sharedApplication().scheduledLocalNotifications else { return }
        for notification in allNotifications {
            if notification.category == alarm.uuid {
                UIApplication.sharedApplication().cancelLocalNotification(notification)
            }
        }
    }
}