//
//  AddIngredientDelegate.swift
//  StefanosSmoothies
//
//  Created by Stefano Iaconetti on 2018-12-04.
//  Copyright © 2018 Stefano Iaconetti. All rights reserved.
//

import Foundation
//AddIngredientDelegate that contains saveIngredient
protocol AddIngredientDelegate {
    func saveIngredient(withName name: String)
}
