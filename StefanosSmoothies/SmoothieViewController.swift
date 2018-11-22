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

class SmoothieViewController: UIViewController {
    //Managed context
    var managedContext: NSManagedObjectContext?
    
    @IBOutlet var tableView: UITableView!
    //This grabs the Smoothies data
    var fetchedResultsController:NSFetchedResultsController<Smoothies>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let moc = managedContext
            else { return }
        
        //Step 4.3
        let fetchRequest = NSFetchRequest<Smoothies>(entityName: "Smoothies")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        
        //Step 4.4
        fetchedResultsController.delegate = self
        
        //Step 4.3
        do{
            try fetchedResultsController.performFetch()
        } catch let error {
            print("Problem fetching results - \(error)")
        }
        
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
