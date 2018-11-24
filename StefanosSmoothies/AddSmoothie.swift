//
//  AddSmoothie.swift
//  StefanosSmoothies
//
//  Created by Stefano Iaconetti on 2018-11-22.
//  Copyright © 2018 Stefano Iaconetti. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class AddSmoothie: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
     @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var ingredientList: UIPickerView!
    
    @IBOutlet var nameText: UITextField!
    
    @IBOutlet var addButton: UIButton!
    
    @IBOutlet var tableView: UITableView!
    var pickerData: [String] = [String]()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        
        self.ingredientList.delegate = self
        self.ingredientList.dataSource = self
        
        // Input the data into the array
        pickerData = ["Blueberries", "Peanut Butter", "Strawberries", "Mangos", "Yogurt", "Spiniach"]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return pickerData[row]
    }
}
    



