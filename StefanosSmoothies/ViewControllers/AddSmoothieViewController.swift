//
//  AddSmoothie.swift
//  StefanosSmoothies
//
//  Created by Stefano Iaconetti on 2018-11-22.
//  Copyright © 2018 Stefano Iaconetti. All rights reserveed
//

//Imports
import Foundation
import UIKit
import CoreData

//This viewcontroller will allow the user to create different smoothies and ingredients
class AddSmoothieViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDataSource, UITableViewDelegate {
    
    //All outlets associated with the viewcontroller
     @IBOutlet var nameLabel: UITextField!
    @IBOutlet var ingredientList: UIPickerView!
    @IBOutlet var nameText: UITextField!
    @IBOutlet var addButton: UIButton!
    @IBOutlet var tableView: UITableView!
    
    //This will be populated with smoothie ingredients
    var ingredientData: [String] = [String]()
    
    //The managed object context
    var managedObjectContext: NSManagedObjectContext?

    //Delegates
    var delegate: AddSmoothieDelegate?
    var ingredientDelegate: AddIngredientDelegate?
    
    //The current food that is about to be added, starts with blueberries
    var addedFood: String = "Blueberries"
    
    //This array will be what the tableview consists of
    var ingredientArray: [String] = []
    
    //When the add button is pressed an ingredient is inserted then data is reloaded
    @IBAction func addPressed(_ sender: Any) {
        
        insertIngredient()
        tableView.reloadData()
    }
    
    //When this button is pressed smoothie is created and ingredients are added to it
    @IBAction func confirmPressed(_ sender: Any) {
        let smoothie = Smoothies(context: managedObjectContext!)
        smoothie.name = nameText.text


        for ingredientList in ingredientArray {
            smoothie.ingredients?.name = ingredientList
        }
        
        
        saveSmoothie()
        
        navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad(){
        super.viewDidLoad()
        
        
        tableView.dataSource = self
        tableView.delegate = self
        
        self.ingredientList.delegate = self
        self.ingredientList.dataSource = self
        
        //Array with different smoothie ingredients
        ingredientData = ["Blueberries", "Peanut Butter", "Strawberries", "Mangos", "Yogurt", "Spiniach", "Banana", "Raspberries", "Pineapples", "Sorbet", "Ice", "Juice"]
        
        
    }
    
    //Function inserts an ingredient into the table
    func insertIngredient(){
        //If the ingredient already exists nothing happens, if not it enters the data into the table
        if ingredientArray.contains(addedFood){
            print("Already an item")
        }else{
            ingredientArray.append(addedFood)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        addedFood = ingredientData[row]
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ingredientData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return ingredientData[row]
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientArray.count
    }
    
    //Populates a cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath)
        
        cell.textLabel?.text = ingredientArray[indexPath.row]
        
        return cell
        
    }
    
    //Saves the smoothie
    func saveSmoothie() {
        //Makes sure that the objectcontext is set
        guard let moc = managedObjectContext
            else { return }
        
        //If we dont have a managed object context there is no saving
        moc.persist {
            do{
                try moc.save()
            } catch {
                moc.rollback()
            }
        }
    }
}
    



