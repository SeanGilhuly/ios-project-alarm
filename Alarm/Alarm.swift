//
//  Alarm.swift
//  Alarm
//
//  Created by Sean Gilhuly on 5/16/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

class Alarm: Equatable, NSCoding {
    
    private let FireTimeFromMidnightKey = "fireTimeFromMidnight"
    private let NameKey = "name"
    private let EnabledKey = "enabled"
    private let UUIDKey = "UUID"
    
    //NSTimeInterval is always specified in seconds
    var fireTimeFromMidnight: NSTimeInterval
    var name: String
    var enabled: Bool
    let uuid: String
    
    init(fireTimeFromMidnight: NSTimeInterval, name: String, enabled: Bool = true, uuid: String = NSUUID().UUIDString) {
        self.fireTimeFromMidnight = fireTimeFromMidnight
        self.name = name
        self.enabled = enabled
        // A UUID is a Universally Unique Identifier
        self.uuid = uuid
        
    }
    
    var fireDate: NSDate? {
        guard let thisMorningAtMidnight = DateHelper.thisMorningAtMidnight else {
            return nil
        }
        let fireDateFromThisMorning = NSDate(timeInterval: fireTimeFromMidnight, sinceDate: thisMorningAtMidnight)
        return fireDateFromThisMorning
    }
    
    var fireTimeAsString: String {
        let fireTimeFromMidnight = Int(self.fireTimeFromMidnight)
        let hours = fireTimeFromMidnight/60/60
        let minutes = (fireTimeFromMidnight - (hours*60*60))/60
        if hours >= 13 {
            return String(format: "%2d:%02d PM", arguments: [hours - 12, minutes])
        } else if hours >= 12 {
            return String(format: "%2d:%02d PM", arguments: [hours, minutes])
        } else {
            return String(format: "%2d:%02d AM", arguments: [hours, minutes])
        }
    }
    //NSCoder stores data, similiar to presistence data (storing information)
    // Similar to a failable initializer
    required init?(coder aDecoder: NSCoder) {
        
        //"aDecoder.decodeObjectForKey" -
        guard let fireTimeFromMidnight = aDecoder.decodeObjectForKey(FireTimeFromMidnightKey) as? NSTimeInterval,
            name = aDecoder.decodeObjectForKey(NameKey) as? String,
            enabled = aDecoder.decodeObjectForKey(EnabledKey) as? Bool,
            uuid = aDecoder.decodeObjectForKey(UUIDKey) as? String else {
                return nil
        }
        self.fireTimeFromMidnight = fireTimeFromMidnight
        self.name = name
        self.enabled = enabled
        self.uuid = uuid
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(fireTimeFromMidnight, forKey: FireTimeFromMidnightKey)
        aCoder.encodeObject(name, forKey: NameKey)
        aCoder.encodeObject(enabled, forKey: EnabledKey)
        aCoder.encodeObject(uuid, forKey: UUIDKey)
    }
    
    
}

func==(lhs: Alarm, rhs: Alarm) -> Bool {
    return lhs.uuid == rhs.uuid
}
