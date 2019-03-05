//
//  EachCategoryTableViewController.swift
//  Li_Yuying_Reminder_Assignment
//
//  Created by Period Three on 2018-10-29.
//  Copyright © 2018 Home. All rights reserved.
//

import UIKit
import UserNotifications
class EachCategoryTableViewController: UITableViewController {

    
    var eachCategory = [Reminder]()
    var index2 = Int()
    var remind: Reminder?
    
    
    override func viewWillAppear(_ animated: Bool) {
        eachCategory = reminders[index2]
        
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }

    // MARK: - Table view data source
    
  

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return eachCategory.count
    }

    //This function saves the new reminder to its category
    @IBAction func unwindToEachCategoryTableView(segue: UIStoryboardSegue) {
        guard segue.identifier == "eachCategorySaveUnwind" else { return }
        let sourceViewController = segue.source as! newReminderTableViewController
        
        if let newReminder2 = sourceViewController.newReminder {
            
            let newIndexPath = IndexPath(row: eachCategory.count, section: 0)
                eachCategory.append(newReminder2)
                tableView.insertRows(at: [newIndexPath],
                                     with: .automatic)
            
            reminders[index2].append(newReminder2)
            Reminder.saveToFile(reminders2: reminders)
           
        }
      
        
    }
    
    //This function shows all the reminders in the table view and if the user click on a row, the check mark will be shown, if the user wants to remove that check mark, he/she just needs to click again. All these changes will be saved.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eachCategoryCell", for: indexPath)
        let oneRemind = eachCategory[indexPath.row]
        
        
        
        cell.textLabel?.text = oneRemind.contextOfReminder
        cell.detailTextLabel?.text = "Due at \(oneRemind.date)"
      
      
            if let remind2 = remind {
            if oneRemind.contextOfReminder == remind2.contextOfReminder {
                if cell.accessoryType == .none && oneRemind.checkMark == true {
                cell.accessoryType = .checkmark
                oneRemind.remain = false
                 Reminder.saveToFile(reminders2: reminders)
                    
                } else if cell.accessoryType == .checkmark {
                 cell.accessoryType = .none
                   oneRemind.checkMark=false
                    oneRemind.remain = true
                  Reminder.saveToFile(reminders2: reminders)
                } else if oneRemind.checkMark == false {
                    cell.accessoryType = .none
                }
            }
            
        }
       
        if oneRemind.checkMark == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
       
        return cell
    }
    
    //This is used to determind whether to show a check mark
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        remind = eachCategory[indexPath.row]
        remind?.checkMark = true
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView,
                               editingStyleForRowAt indexPath: IndexPath) ->
        UITableViewCell.EditingStyle {
            return .delete
    }
    
    //When the user delete a reminder, all information about that reminder will be deleted and all these changes will be saved
    override func tableView(_ tableView: UITableView, commit
        editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath:
        IndexPath) {
        if editingStyle == .delete {
            
            eachCategory.remove(at: indexPath.row)
            reminders[index2].remove(at: indexPath.row)
            Reminder.saveToFile(reminders2: reminders)
            notifications.remove(at: indexPath.row)
            Notification.saveToFile(notification2: notifications)
            
          
            tableView.deleteRows(at: [indexPath], with: . automatic)
        }
    }
   
    
   

}
