//
//  notificationFile.swift
//  Li_Yuying_Reminder_Assignment
//
//  Created by Period Three on 2018-11-02.
//  Copyright © 2018 Home. All rights reserved.
//

import Foundation
import UserNotifications
// This is the model for notifications. It includes the properties of title, subtitle,body identifire and day. There are two static functions that are used to save data(use codable)
class Notification: Codable {
    var title: String
    var subtitle: String
    var body: String
    var identifire: String
    var day: Date
    
    init(title:String ,subtitle:String, body:String, identifire:String, day: Date) {
        
        self.title = title
        self.subtitle = subtitle
        self.body = body
        self.identifire = identifire
        self.day = day
    }
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let archiveURL = documentsDirectory.appendingPathComponent("Notification_test").appendingPathExtension("plist")
    
    static var returnValue = Array<Notification>()
    static func saveToFile(notification2: [Notification]) {
        let propertyListEncoder = PropertyListEncoder()
        let encodedNotifications = try? propertyListEncoder.encode(notification2)
        try? encodedNotifications?.write(to: Notification.archiveURL, options: .noFileProtection)
    }
    
    static func loadedFromFile()->Array<Notification> {
        let propertyListDecoder = PropertyListDecoder()
        if let retrieveNotificationData = try? Data(contentsOf: Notification.archiveURL), let decodedNotification = try? propertyListDecoder.decode(Array<Notification>.self, from: retrieveNotificationData){
            returnValue = decodedNotification
        }
        return returnValue
    }
    static func loadSampleCategories() -> [Notification] {
        return notifications
    }

}


// This array is used to save all notifications that user has built
var notifications: [Notification] = []
