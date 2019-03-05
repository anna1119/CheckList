//
//  SelectIconTableViewController.swift
//  Li_Yuying_Reminder_Assignment
//
//  Created by Period Three on 2018-10-26.
//  Copyright © 2018 Home. All rights reserved.
//

import UIKit

protocol SelectIconTableViewControllerDelegate {
    func didSelect(iconStructure: IconStructure, iconImage: UIImage)
}

class SelectIconTableViewController: UITableViewController {
    //These two variables are used to refer to a particular image
    var delegate: SelectIconTableViewControllerDelegate?
    var iconTitleGlobal: IconStructure?
    var imageChoice: UIImage?
    var selectedImageArray = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    //The number of sections in this view is one
    override func numberOfSections(in tableView: UITableView) -> Int {
      
        return 1
    }

    //The number of rows in the section will depend on the number of different categories.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return IconStructure.all.count
    }


    //When the user select a row, the icon image in that row will be recorded.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        iconTitleGlobal = IconStructure.all[indexPath.row]
        imageChoice = iconImage[indexPath.row]
        delegate?.didSelect(iconStructure: iconTitleGlobal!, iconImage: imageChoice!)
        tableView.reloadData()
    }
    
    //When the user chooses a category, the check mark will appear.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "selectIconCell", for: indexPath)
        let iconTitle2 = IconStructure.all[indexPath.row]
        cell.textLabel?.text = iconTitle2.iconTitle
        cell.imageView?.image = iconImage[indexPath.row]
        if let iconGlobal2 = iconTitleGlobal {
            if iconTitle2.iconTitle == iconGlobal2.iconTitle {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        }
        return cell
    }
  
}
