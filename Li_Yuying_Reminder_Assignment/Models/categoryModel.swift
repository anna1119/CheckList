//
//  categoryModel.swift
//  Li_Yuying_Reminder_Assignment
//
//  Created by Period Three on 2018-11-02.
//  Copyright © 2018 Home. All rights reserved.
//

import Foundation
import UIKit

// This model is used for categories. One category has its name and description. Name of the catetory will be the title of table view cell and descriptions will be the subtitle of table view cell. There are three static functions inside the model, which are used to save data.(use codable)

class CategoryClass: Codable {
    var name:String
    var description:String
    init(name:String, description:String) {
        self.name = name
        self.description = description
        
    }
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let archiveURL = documentsDirectory.appendingPathComponent("Category_test").appendingPathExtension("plist")
    
    static var returnValue = Array<CategoryClass>()
    static func saveToFile(categories2: [CategoryClass]) {
        let propertyListEncoder = PropertyListEncoder()
        let encodedCategories = try? propertyListEncoder.encode(categories2)
        try? encodedCategories?.write(to: CategoryClass.archiveURL, options: .noFileProtection)
    }
    
    static func loadedFromFile()->Array<CategoryClass> {
        let propertyListDecoder = PropertyListDecoder()
        if let retrieveCategoryData = try? Data(contentsOf: CategoryClass.archiveURL), let decodedCategories = try? propertyListDecoder.decode(Array<CategoryClass>.self, from: retrieveCategoryData){
            returnValue = decodedCategories
        }
        return returnValue
    }
    static func loadSampleCategories() -> [CategoryClass] {
        return categories
    }
    
    
}


//This array is used to save all categories that user has built.
var categories = [CategoryClass]()



