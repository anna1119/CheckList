//
//  AddCategoryTableViewController.swift
//  Li_Yuying_Reminder_Assignment
//
//  Created by Period Three on 2018-10-25.
//  Copyright © 2018 Home. All rights reserved.
//

import UIKit

class AddCategoryTableViewController: UITableViewController, SelectIconTableViewControllerDelegate {
    
    //This function is included in the protocal. When a user chooses a icon image and return back to this view controller, the icon image will be updated.
    func didSelect(iconStructure: IconStructure, iconImage: UIImage) {
        self.iconTitleGlobal = iconStructure
        self.imageChoice = iconImage
        updateIconChoice()
    }
    
   //Use these two variables to represent the icon image that the user chooses
    var iconTitleGlobal: IconStructure?
    var imageChoice: UIImage?
    
    //This variable will be used when the user does not choose an icon image.
    var icon = IconStructure(iconTitle: "Folder")
    
    //When the user chooses a icon image, the image of the table view cell will be updated. Otehrwise, it will show the default value which is the image of folder.
    func updateIconChoice() {
        if let iconTitleGlobal = iconTitleGlobal {
            iconLabel.text = iconTitleGlobal.iconTitle
            iconImage.image = imageChoice
        } else {
            iconLabel.text = "Folder"
            iconImage.image = #imageLiteral(resourceName: "folderIcon")
           
            }
       
    }
  
    //When the user provide all the necessary information, she/he will be able to save it.
    func updateSaveButtonState() {
    let nameText = nameTextField.text ?? ""
    let descriptionText = descriptionTextField.text ?? ""
    saveButton.isEnabled = !nameText.isEmpty && !descriptionText.isEmpty
    }
    
    
    

    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var iconLabel: UILabel!
    
    @IBOutlet weak var iconImage: UIImageView!
    
    
    
    
    //When the user chooses to select icon image, all things needed will be transfered to the select icon view controller. When the user chooses to save the new category, all information about category will be saved.
    override func prepare(for segue: UIStoryboardSegue, sender:
        Any?) {
        super.prepare(for: segue, sender: sender)
        
        
        if segue.identifier == "SelectIcon" {
            let destinationViewController = segue.destination as? SelectIconTableViewController
            destinationViewController?.delegate = self
            destinationViewController?.iconTitleGlobal = iconTitleGlobal
            destinationViewController?.imageChoice = imageChoice
                    }
        
        
        guard segue.identifier == "saveUnwind" else { return }
        
        let name = nameTextField.text ?? ""
        let description = descriptionTextField.text ?? ""
        
        category = CategoryClass(name: name, description: description)
        
        if let icon  = iconTitleGlobal {
            coreIcon.append(icon)
            IconStructure.saveToFile(icon2: coreIcon)
        } else {
            coreIcon.append(icon)
        IconStructure.saveToFile(icon2: coreIcon)
        }
        reminders.append([Reminder]())
        Reminder.saveToFile(reminders2: reminders)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //This two function will update something after the data is loaded
        updateSaveButtonState()
        updateIconChoice()
    }
    

    var category: CategoryClass?
    
    //The save button will be enabled as soon as the user provides all the information
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    //This function will remove the grey highlight when the user chooses a row.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
 

}
