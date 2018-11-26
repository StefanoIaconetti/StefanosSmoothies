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

class SmoothieViewController: UIViewController, AddSmoothieDelegate, MOCViewControllerType  {
    var managedObjectContext: NSManagedObjectContext?
    

    @IBOutlet var tableView: UITableView!
    //This grabs the Smoothies data
    var fetchedResultsController: NSFetchedResultsController<Smoothies>?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        guard let moc = managedObjectContext
            else { return }
        
        let fetchRequest = NSFetchRequest<Smoothies>(entityName: "Smoothies")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController?.delegate = self
        
        do{
            try fetchedResultsController?.performFetch()
        } catch let error {
            print("Problem fetching results - \(error)")
        }
        
    }
    
    func saveSmoothie(withName name: String) {
        //Makes sure that the objectcontext is set
        guard let moc = managedObjectContext
            else { return }
        
        //If we dont have a managed object context there is no saving
        moc.persist {
            let smoothie = Smoothies(context: moc)
            smoothie.name = name
            
            do{
                try moc.save()
                print("No Problem")
            } catch {
                moc.rollback()
                print("Problem")
            }
        }
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navVC = segue.destination as? UINavigationController,
            let addSmoothieVC = navVC.viewControllers[0] as? AddSmoothie {
            
            addSmoothieVC.delegate = self
        }
        
        
        guard let selectedIndex = tableView.indexPathForSelectedRow
            else { return }
        
        
        tableView.deselectRow(at: selectedIndex, animated: true)
    }
    
}
// MARK: - Extensions

extension SmoothieViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController? .fetchedObjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SmoothieCell")
            else { fatalError("Wrong cell identifier requested") }
        
        guard let smoothie = fetchedResultsController?.object(at: indexPath)else{return cell}
        cell.textLabel?.text = smoothie.name
        return cell
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
