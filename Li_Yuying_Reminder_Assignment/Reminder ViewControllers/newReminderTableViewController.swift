//
//  newReminderTableViewController.swift
//  Li_Yuying_Reminder_Assignment
//
//  Created by Home on 2018-10-27.
//  Copyright © 2018 Home. All rights reserved.
//

import UIKit
import UserNotifications
class newReminderTableViewController: UITableViewController {
    //When the user click on the date row, the date picker will be shown
     let dueDatePickerCellIndexPath = IndexPath(row: 1, section: 2)
    var isDueDatePickerShown: Bool = false {
        didSet {
            DueDatePicker.isHidden = !isDueDatePickerShown
        }
    }
    @IBOutlet weak var reminderNameTextField: UITextField!
    
    @IBOutlet weak var saveButton2: UIBarButtonItem!
    @IBOutlet weak var dueDateLabel: UILabel!
    
    @IBOutlet weak var switchTapped: UISwitch!
    
    @IBOutlet weak var DueDatePicker: UIDatePicker!
    
    //When the user chooses a time, the text of the day label will be updated.
    func updateDateViews() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dueDateLabel.text = dateFormatter.string(from: DueDatePicker.date)
    }
    
    //When the user finishes all the blank, she/he will be able to save the new reminder.
    func updateSaveButtonState() {
        let reminderNameText = reminderNameTextField.text ?? ""
        saveButton2.isEnabled = !reminderNameText.isEmpty
    }
    
    //These two variables represent the new reminder that will be created
    var newReminder: Reminder?
    var newNotification: Notification?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //The default value of date picker will always be the midnight of that day
      let midnightToday = Calendar.current.startOfDay(for: Date())
      DueDatePicker.minimumDate = midnightToday
      DueDatePicker.date = midnightToday
        updateDateViews()
        updateSaveButtonState()
        
        //This will show an alert box to ask the user whether they allow this app to send them nofitications
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in
            
        })
        
    }
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    
    //When the user presses the save button, all information about the new reminder will be sent and saved. If the user requires the notification, the time of that notification will be saved.
    override func prepare(for segue: UIStoryboardSegue, sender:
        Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "eachCategorySaveUnwind" else { return }
        
        
        let contextOfReminder = reminderNameTextField.text ?? ""
        let date = dueDateLabel.text!
        let notification = switchTapped.isOn
        newReminder = Reminder(contextOfReminder: contextOfReminder, date: date, pushNotifications: notification)
        
        let titleOfNotification = "There is a reminder due!"
        let subtitleOfNotification = reminderNameTextField.text ?? ""
        let bodyOfNotification = "Due at \(dueDateLabel.text!)"
        let identifireOfNotification = reminderNameTextField.text ?? ""
        
        if switchTapped.isOn {
            newNotification = Notification(title: titleOfNotification, subtitle: subtitleOfNotification, body: bodyOfNotification, identifire: identifireOfNotification, day: DueDatePicker.date)
            notifications.append(newNotification!)
            Notification.saveToFile(notification2: notifications)
            
        }
        
        
        for existingNitification in notifications{
            let content = UNMutableNotificationContent()
            content.title = existingNitification.title
            content.subtitle = existingNitification.subtitle
            content.body = existingNitification.body
            let dateComponents = Calendar.current.dateComponents([.day, .hour, .minute], from: existingNitification.day)
            let triggerDate = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            
            let request = UNNotificationRequest(identifier: existingNitification.identifire, content: content, trigger: triggerDate)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
        
        
        
    }
   
    //This function is used to set the height of the cell
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath.section, indexPath.row) {
        case (dueDatePickerCellIndexPath.section, dueDatePickerCellIndexPath.row):
            if isDueDatePickerShown {
                return 216
            } else {
                return 0.0
            }
        default:
            return 50.0
        }
    }
    
    
    
    @IBAction func saveButton2(_ sender: Any) {
        
        
       
        
    }
    
    
    @IBAction func switchTapped(_ sender: UISwitch) {
 
        
    }
    
    //When the user changes the time, the text of label will be updated
    @IBAction func DueDatePicker(_ sender: UIDatePicker) {
        updateDateViews()
    }
    
    //This funciton enables the user to choose a date
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       tableView.deselectRow(at: indexPath, animated: true)
        
        switch (indexPath.section, indexPath.row) {
        case (dueDatePickerCellIndexPath.section, dueDatePickerCellIndexPath.row - 1):
            if isDueDatePickerShown {
                isDueDatePickerShown = false
            } else {
                isDueDatePickerShown = true
            }
            tableView.beginUpdates()
            tableView.endUpdates()
            
        default:
            break
        }
        
        
    }
    
   


}
