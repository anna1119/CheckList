//
//  CategoryTableViewController.swift
//  Li_Yuying_Reminder_Assignment
//
//  Created by Home on 2018-10-24.
//  Copyright © 2018 Home. All rights reserved.
//

import UIKit
import UserNotifications
class CategoryTableViewController: UITableViewController {

   
 
    override func viewWillAppear(_ animated: Bool) {
      
        //These will be called before the view appears on the screen. All stored titles of icon will be loaded from file and been transformed to icon images, and the table view will reload data.
        coreIcon = IconStructure.loadedFromFile()
        transform()
       
        tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // This will make the view controller show the data that has been loaded
        
        categories = CategoryClass.loadedFromFile()
        notifications = Notification.loadedFromFile()
        reminders = Reminder.loadedFromFile()
        if coreIcon.count > 0 {
        coreIcon = IconStructure.loadedFromFile()
        transform()
        }
       
    }

    // When the user click the edit button, he/she will be able to delete or reorder those categories.
    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        let tableViewEditingMode = tableView.isEditing
        tableView.setEditing(!tableViewEditingMode, animated: true)
    }
  
    
    // This table view only has one section
    override func numberOfSections(in tableView: UITableView) -> Int {
      return 1
        
    }
  
    //The numebr of rows in section will depend on how many categories the user has built.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        if section == 0 {
            return categories.count
        } else {
            return 0
        }
    }

    // This function will make the table view show different categories and their icon images. It will also allows the users to reorder the cell. "count" variable will show the number of items that do not have check marks.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categories[indexPath.row]
        cell.textLabel?.text = category.name
        
        var count = 0
       for remainThing in reminders[indexPath.row] {
           if remainThing.remain == true {
              count += 1
            }
        }
        cell.detailTextLabel?.text = "\(category.description) (\(count) Remaining)"
        
        imagesArray.removeAll()
        transform()
        cell.imageView?.image = imagesArray[indexPath.row]
        cell.showsReorderControl = true
        
        return cell
    }
    
    // This function will be used when the user wants to reorder the categories. All these changes will be saved. The table view will reload data.
    override func tableView(_ tableView: UITableView, moveRowAt
        fromIndexPath: IndexPath, to: IndexPath) {
        let movedCategory = categories.remove(at: fromIndexPath.row)
        categories.insert(movedCategory, at: to.row)
        CategoryClass.saveToFile(categories2: categories)
        
        let movedImage = imagesArray.remove(at: fromIndexPath.row)
        imagesArray.insert(movedImage, at: to.row)
        
        let movedCore = coreIcon.remove(at: fromIndexPath.row)
        coreIcon.insert(movedCore, at: to.row)
        IconStructure.saveToFile(icon2: coreIcon)
        
        let movedReminder = reminders.remove(at: fromIndexPath.row)
        reminders.insert(movedReminder, at: to.row)
        Reminder.saveToFile(reminders2: reminders)
        
        tableView.reloadData()
        
    }
   
    //This function enables the delete option
    override func tableView(_ tableView: UITableView,
                               editingStyleForRowAt indexPath: IndexPath) ->
        UITableViewCell.EditingStyle {
            return .delete
    }
   
    
    
   
    //When the user delete the rows, the changed information will be saved.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
           categories.remove(at: indexPath.row)
            CategoryClass.saveToFile(categories2: categories)
            coreIcon.remove(at: indexPath.row)
            IconStructure.saveToFile(icon2: coreIcon)
            reminders.remove(at: indexPath.row)
            Reminder.saveToFile(reminders2: reminders)
            
          tableView.deleteRows(at: [indexPath], with: .automatic)
        } 
    }
    
    
    
    //When the user add a new category and press the save button, this category will be saved into categories.
    @IBAction func unwindToCategoryTableView(for unwindSegue: UIStoryboardSegue) {
    guard unwindSegue.identifier == "saveUnwind" else { return }
        let sourceViewController = unwindSegue.source as!
        AddCategoryTableViewController
        
        if let category = sourceViewController.category {
            if let selectedIndexPath =
                tableView.indexPathForSelectedRow {
                categories[selectedIndexPath.row] = category
                CategoryClass.saveToFile(categories2: categories)
                tableView.reloadRows(at: [selectedIndexPath],
                                     with: .none)
            } else {
                let newIndexPath = IndexPath(row: categories.count,
                                             section: 0)
                categories.append(category)
                CategoryClass.saveToFile(categories2: categories)
                tableView.insertRows(at: [newIndexPath],
                                     with: .automatic)
            }
        }
        
        
        
        
     
    }
    
    //Didfferent index values represent different reminders in different categories.
    var index = Int()
    
    //When the user wants to add reminders in a particular category, the stored reminders in that category will be shown. All things shown are included in that category.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "eachCategory" {
            let indexPath = tableView.indexPathForSelectedRow!
            let eachCategory2 = reminders[indexPath.row]
            index = indexPath.row
            let eachCategoryTableViewController = segue.destination as! EachCategoryTableViewController
            eachCategoryTableViewController.eachCategory = eachCategory2
            eachCategoryTableViewController.index2 = index
            
        }
    }
    
    
    
    
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
