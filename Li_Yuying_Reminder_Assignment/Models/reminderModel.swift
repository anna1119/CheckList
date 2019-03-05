//
//  reminderModel.swift
//  Li_Yuying_Reminder_Assignment
//
//  Created by Period Three on 2018-11-02.
//  Copyright © 2018 Home. All rights reserved.
//

import Foundation

// This is the model for reminders. This model includes the properties of context, date, pushnotifications and checkMark. There are two static functions that are used to save data(use codable)
class Reminder: Codable {
    var contextOfReminder: String
    var date: String
    var pushNotifications: Bool
    var checkMark: Bool = false //This determines whether to show a check mark
    var remain: Bool = true //This determines the number of remaining things
    
    init(contextOfReminder: String, date: String, pushNotifications: Bool) {
        self.contextOfReminder = contextOfReminder
        self.date = date
        self.pushNotifications = pushNotifications
    }
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let archiveURL = documentsDirectory.appendingPathComponent("Reminder_test").appendingPathExtension("plist")
    
    static var returnValue = [[Reminder]]()
    static func saveToFile(reminders2: [[Reminder]]) {
        let propertyListEncoder = PropertyListEncoder()
        let encodedReminders = try? propertyListEncoder.encode(reminders2)
        try? encodedReminders?.write(to: Reminder.archiveURL, options: .noFileProtection)
    }
    
    static func loadedFromFile()-> [[Reminder]] {
        let propertyListDecoder = PropertyListDecoder()
        if let retrieveReminderData = try? Data(contentsOf: Reminder.archiveURL), let decodedReminders = try? propertyListDecoder.decode([[Reminder]].self, from: retrieveReminderData){
            returnValue = decodedReminders
        }
        return returnValue
    }
    static func loadSampleCategories() -> [[Reminder]] {
        return reminders
    }
    

}


// When a user build a new category, an array of Reminder will be added into the reminders. Every array of Reminder refers to different category.
var reminders: [[Reminder]] = []

