//
//  ViewController.swift
//  StefanosSmoothies
//
//  Created by Stefano Iaconetti on 2018-11-05.
//  Copyright © 2018 Stefano Iaconetti. All rights reserved.

//Imports
import Foundation
import UIKit
import CoreData

//SmoothieViewController contains all of the tableview data
class SmoothieViewController: UIViewController, MOCViewControllerType  {
    //MOC
    var managedObjectContext: NSManagedObjectContext?
    
    //Creates the animator
    var hideAnimator: CustomModalHideAnimator?
    
    //Linked to the tableview in the storyboard
    @IBOutlet var tableView: UITableView!
    
    //This grabs the Smoothies data
    var fetchedResultsController: NSFetchedResultsController<Smoothies>?

    //ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        transitioningDelegate = self
        
        //Creates instance of CustomModalHideAnimator and binds the viewController
        hideAnimator = CustomModalHideAnimator(withViewController: self)
        
        
        tableView.delegate = self
        tableView.dataSource = self
        //Creating the moc or it returns nothing
        guard let moc = managedObjectContext
            else { print("nothing here")
                return }
        
        //Creates a fetch request
        let fetchRequest = NSFetchRequest<Smoothies>(entityName: "Smoothies")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController?.delegate = self
        
        //Attempts to perform the fetch, if not return an error
        do{
            try fetchedResultsController?.performFetch()
        } catch let error {
            print("Problem fetching results - \(error)")
        }
        
    }
    
   
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addSmoothieVC = segue.destination as? AddSmoothieViewController{
            addSmoothieVC.managedObjectContext = managedObjectContext
        }
        
        //Finds which cell is being selected
        guard let selectedIndex = tableView.indexPathForSelectedRow
            else { return }
        
        //Depending on the cell thats selected you are directed to the EditViewcontroller to then be able to update and edit the content
        if let editSmoothieVC = segue.destination as? EditSmoothieViewController,
            let smoothie = fetchedResultsController?.object(at: selectedIndex) {
            editSmoothieVC.managedObjectContext = managedObjectContext
            editSmoothieVC.smoothie = smoothie
            
        }
        
        
        tableView.deselectRow(at: selectedIndex, animated: true)
    }
    
}

// MARK: - Extensions
//Extension to the tableview delegate and datasource
extension SmoothieViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController? .fetchedObjects?.count ?? 0
    }
    
    //Grabs the correct cell and adds the information
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SmoothieCell")
            else { fatalError("Wrong cell identifier requested") }
        
        guard let smoothie = fetchedResultsController?.object(at: indexPath)else{return cell}
        cell.textLabel?.text = smoothie.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //This allows the user to delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            //Makes sure that the objectcontext is set
            guard let moc = managedObjectContext
                else { return }
           
            //Smoothie that is found
            let foundSmoothie = fetchedResultsController?.object(at: indexPath)
            
            //Dialog that will be presented
            let message = UIAlertController(title: "Would you like to delete this smoothie?", message: "You are currently deleting \(foundSmoothie!.name!)", preferredStyle: .actionSheet)
            
            //This is called when the user selects it in the action sheet
            let deleteAction = UIAlertAction(title: "Yes", style: .destructive, handler: {action in
                //If we dont have a managed object context there is no saving
                moc.persist {
                        moc.delete(foundSmoothie!)
                    
                }
            })
            
            //Gives them the ability to cancel
            let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
            
            //Adding the actions
            message.addAction(deleteAction)
            message.addAction(cancelAction)
            
            //Displays
            present(message, animated: true, completion:  nil)
        }
    }
}

extension SmoothieViewController: NSFetchedResultsControllerDelegate{
    //Notifies table view when updates will occur
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    //Notifies table view when updates will end
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    //Responsible for recieveing and processing updates
    //Recieves type NSFetchedResultsChangeType
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?){
        //With the recieved type we determine to insert delete move or update
        switch type{
        case.insert:
            guard let insertIndex = newIndexPath else {return}
            tableView.insertRows(at: [insertIndex], with: .automatic)
        case .delete:
            guard let deleteIndex = indexPath else {return}
            tableView.deleteRows(at: [deleteIndex], with: .automatic)
        case.move:
            guard let fromIndex = indexPath, let toIndex = newIndexPath else { return }
            tableView.moveRow(at: fromIndex, to: toIndex)
        case .update:
            guard let updateIndex = indexPath else{ return }
            tableView.reloadRows(at: [updateIndex], with: .automatic)
        }
    }
    
}

extension SmoothieViewController: UIViewControllerTransitioningDelegate{
    //Adds conformance to the UIViewControllerTransitioningDelegate protocal and assigns viewcontroller as its own transitioning delegate
    func animationController(forPresentedController presented: UIViewController, presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomModalShowAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return hideAnimator
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        return hideAnimator
    }
}
