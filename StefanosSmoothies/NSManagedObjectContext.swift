//
//  NSManagedObjectContext.swift
//  StefanosSmoothies
//
//  Created by Jaimilyn Vanderheyde on 2018-11-24.
//  Copyright © 2018 Stefano Iaconetti. All rights reserved.
//

import Foundation
import CoreData
// MARK: - Extensions
extension NSManagedObjectContext {
    //Helps reduce amount of boilerplate code
    func persist(block: @escaping () -> Void) {
        perform {
            block()
            do{
                try self.save()
            } catch {
                self.rollback()
            }
        }
    }
}
