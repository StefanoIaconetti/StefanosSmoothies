//
//  EditSmoothieViewController.swift
//  StefanosSmoothies
//
//  Created by Jaimilyn Vanderheyde on 2018-12-01.
//  Copyright © 2018 Stefano Iaconetti. All rights reserved.
//

import Foundation

import Foundation
import UIKit
import CoreData
import UserNotifications

class EditSmoothieViewController: UIViewController{
    
    @IBOutlet var ingredientList: UIPickerView!
    @IBOutlet var nameText: UITextField!
    @IBOutlet var addButton: UIButton!
    @IBOutlet var tableView: UITableView!
    var pickerData: [String] = [String]()
    
    var smoothie: Smoothies?
    
    var managedObjectContext: NSManagedObjectContext?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let smoothie = smoothie {
            nameText.text = smoothie.name
        }
        
    }

}
