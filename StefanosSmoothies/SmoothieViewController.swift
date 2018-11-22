//
//  ViewController.swift
//  StefanosSmoothies
//
//  Created by Stefano Iaconetti on 2018-11-05.
//  Copyright © 2018 Stefano Iaconetti. All rights reserved.
//
import Foundation
import UIKit
import CoreData

class SmoothieViewController: UITableViewController {
    //Managed context
    var managedContext: NSManagedObjectContext!
    
    //This grabs the Smoothies data
    var fetchedResultsController:NSFetchedResultsController<Smoothies>!
    
    override func viewDidLoad() {
        
        //Step 4.3
        let fetchRequest = NSFetchRequest<Smoothies>(entityName: "Smoothies")
        fetchRequest.sortDescriptors = []
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedContext, sectionNameKeyPath: nil, cacheName: nil)
        
        //Step 4.4
        fetchedResultsController.delegate = self
        
        //Step 4.3
        do{
            try fetchedResultsController.performFetch()
        } catch let error {
            print("Problem fetching results - \(error)")
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SmoothieCell", for: indexPath)
        
        let smoothie = fetchedResultsController.object(at: indexPath)
        
        cell.textLabel?.text = smoothie.name
        
        return cell
    }
    
}

//This extension conforms to the NSFetchedResultsControllerdelegate
extension SmoothieViewController: NSFetchedResultsControllerDelegate{
    //Didchange method
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    //Willchange method
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    //controller (_ : didchange) method
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        //This will give the user the ability to update, insert move and delete
        switch type{
        case .delete:
            guard let deleteIndexPath = indexPath else { return }
            tableView.deleteRows(at: [deleteIndexPath], with: .automatic)
        case .insert:
            guard let insertPath = newIndexPath else { return }
            tableView.insertRows(at: [insertPath], with: .automatic)
        case .move:
            guard let newPath = newIndexPath, let oldPath = indexPath else { return }
            tableView.moveRow(at: oldPath, to: newPath)
        case .update:
            guard let existingPath = indexPath else { return }
            tableView.reloadRows(at: [existingPath], with: .automatic)
        }
    }
    
    
}
