//
//  AppDelegate.swift
//  StefanosSmoothies
//
//  Created by Stefano Iaconetti on 2018-11-05.
//  Copyright © 2018 Stefano Iaconetti. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    //Loads data model and connects it to a persistent store
      private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SmoothieModel")
        
        //If there is a error show the error
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                fatalError("Unresolved error \(error), \(error.localizedDescription)")
            }
            
        })
        return container
    }()
    
    //Save function, in case of app termination
//    func saveContext(){
//        let context = persistentContainer.viewContext
//        if context.hasChanges{
//            do {
//                try context.save()
//            } catch let error {
//                fatalError("Unresolved error when saving - \(error)")
//            }
//        }
//    }
    
    //Access the ViewController
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        if let rootVC = window?.rootViewController as? UINavigationController, let mainVC = rootVC.viewControllers[0] as? SmoothieViewController{
            mainVC.managedObjectContext = persistentContainer.viewContext
        }
        
        application.setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)
        return true
    }
    
    
//When application is about to terminate
    func applicationWillTerminate(_ application: UIApplication) {
        //Saves the context
            persistentContainer.saveContextIfNeeded()
        }


}

