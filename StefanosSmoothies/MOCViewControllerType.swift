//
//  MOCViewControllerType.swift
//  StefanosSmoothies
//
//  Created by Jaimilyn Vanderheyde on 2018-11-24.
//  Copyright © 2018 Stefano Iaconetti. All rights reserved.
//

import Foundation
import CoreData

// MARK: - MOCViewControllerType
protocol MOCViewControllerType{
    var managedObjectContext: NSManagedObjectContext? {get set}
    
}
