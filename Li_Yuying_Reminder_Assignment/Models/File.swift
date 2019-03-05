//
//  File.swift
//  Li_Yuying_Reminder_Assignment
//
//  Created by Home on 2018-10-24.
//  Copyright © 2018 Home. All rights reserved.
//

import Foundation
import UIKit

//These images are used to represent different categories
let iconImage: [UIImage] = [#imageLiteral(resourceName: "noIcon"), #imageLiteral(resourceName: "appointmentsIcon"), #imageLiteral(resourceName: "birthdayIcon"), #imageLiteral(resourceName: "choresIcon"), #imageLiteral(resourceName: "drinksIcon"), #imageLiteral(resourceName: "folderIcon"), #imageLiteral(resourceName: "groceriesIcon"), #imageLiteral(resourceName: "inboxIcon"), #imageLiteral(resourceName: "photosIcon"), #imageLiteral(resourceName: "tripsIcon")]



// This structure is used to show the icon and their names. There are two static functions in it which are used to save data(use codable)
struct IconStructure: Codable {
    var iconTitle: String
    
    init(iconTitle:String) {
        self.iconTitle = iconTitle
    }
    
    
    static var all: [IconStructure] {
        return [IconStructure(iconTitle: "No icon"), IconStructure(iconTitle: "Appointments"), IconStructure(iconTitle: "Birthdays"), IconStructure(iconTitle: "Chores"), IconStructure(iconTitle: "Drinks"), IconStructure(iconTitle: "Folder"), IconStructure(iconTitle: "Groceries"), IconStructure(iconTitle: "Inbox"), IconStructure(iconTitle: "Photos"), IconStructure(iconTitle: "Trips")]
    }
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let archiveURL = documentsDirectory.appendingPathComponent("Icon_test").appendingPathExtension("plist")
    
    static var returnValue = Array<IconStructure>()
    static func saveToFile(icon2: [IconStructure]) {
        let propertyListEncoder = PropertyListEncoder()
        let encodedIcons = try? propertyListEncoder.encode(icon2)
        try? encodedIcons?.write(to: IconStructure.archiveURL, options: .noFileProtection)
    }
    
    static func loadedFromFile()->Array<IconStructure> {
        let propertyListDecoder = PropertyListDecoder()
        if let retrieveIconData = try? Data(contentsOf: IconStructure.archiveURL), let decodedIcon = try? propertyListDecoder.decode(Array<IconStructure>.self, from: retrieveIconData){
            returnValue = decodedIcon
        }
        return returnValue
    }
    static func loadSampleIcons() -> [IconStructure] {
        return coreIcon
    }
    
   

}

// This array is used to contain the transformed images
var imagesArray = [UIImage]()



// This array is used to store the titles of icons that user has chosen.
var coreIcon = [IconStructure]()

//This function will put related images into imagesArray according to their name
func transform() {
    for icon in coreIcon {
        switch icon.iconTitle {
        case "No icon": imagesArray.append(#imageLiteral(resourceName: "noIcon"))
        case "Appointments": imagesArray.append(#imageLiteral(resourceName: "appointmentsIcon"))
        case "Birthdays": imagesArray.append(#imageLiteral(resourceName: "birthdayIcon"))
        case "Chores": imagesArray.append(#imageLiteral(resourceName: "choresIcon"))
        case "Drinks": imagesArray.append(#imageLiteral(resourceName: "drinksIcon"))
        case "Folder": imagesArray.append(#imageLiteral(resourceName: "folderIcon"))
        case "Groceries": imagesArray.append(#imageLiteral(resourceName: "groceriesIcon"))
        case "Inbox": imagesArray.append(#imageLiteral(resourceName: "inboxIcon"))
        case "Photos": imagesArray.append(#imageLiteral(resourceName: "photosIcon"))
        default: imagesArray.append(#imageLiteral(resourceName: "tripsIcon"))
            
        }
  
    }
}
