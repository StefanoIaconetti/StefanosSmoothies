//
//  AboutMeViewController.swift
//  StefanosSmoothies
//
//  Created by Jaimilyn Vanderheyde on 2018-11-24.
//  Copyright © 2018 Stefano Iaconetti. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class AboutMeViewController: UIViewController{
    
    @IBOutlet var linkToWebsite: UIButton!
    
    @IBAction func linkPressed(_ sender: Any) {
         let url = URL(string: "https://php.scweb.ca/~siaconetti968/Portfolio/Project/StefanoIaconetti/software.html")
        
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
       
    }
        
    override func viewDidLoad(){
        super.viewDidLoad()
    }
    
}
