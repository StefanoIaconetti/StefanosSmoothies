//
//  NSPersistentContainer.swift
//  StefanosSmoothies
//
//  Created by Jaimilyn Vanderheyde on 2018-11-24.
//  Copyright © 2018 Stefano Iaconetti. All rights reserved.
//

import Foundation
import CoreData
// MARK: - Extension
extension NSPersistentContainer {
    
    //Adds custom method to the persistent container so we can call on instances of the container
    func saveContextIfNeeded() {
        if viewContext.hasChanges {
            do{
                try viewContext.save()
            } catch{
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
