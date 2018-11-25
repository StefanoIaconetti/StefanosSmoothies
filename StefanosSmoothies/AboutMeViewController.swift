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
import UserNotifications

class AboutMeViewController: UIViewController{
    @IBOutlet weak var switchCheck: UISwitch!
    
    @IBOutlet var linkToWebsite: UIButton!
    
    @IBAction func sendNotifications(_ sender: Any) {
        if(switchCheck.isOn == true){
            // Configure the recurring date.
            var dateComponents = DateComponents()
            dateComponents.calendar = Calendar.current
            
            // Makes the date wednesday at 12:00 PM
            dateComponents.weekday = 5
            dateComponents.hour = 12
            
            let content = UNMutableNotificationContent()
            content.title = "Have you been making smoothies?"
            content.body = "Make sure to write down your smoothies!"
            content.sound = UNNotificationSound.default()
            content.badge = 1
            
            // Trigger
            let trigger = UNCalendarNotificationTrigger(
                dateMatching: dateComponents, repeats: true)
            
            // Creating request
            let uuidString = UUID().uuidString
            let request = UNNotificationRequest(identifier: uuidString,
                                                content: content, trigger: trigger)
            
            // Scheduling request
            let notificationCenter = UNUserNotificationCenter.current()
            notificationCenter.add(request) { (error) in
                if error != nil {
                    print("error adding the notification - \(error?.localizedDescription)")
                }
            }
        }
    }
    
    @IBAction func linkPressed(_ sender: Any) {
         let url = URL(string: "https://php.scweb.ca/~siaconetti968/Portfolio/Project/StefanoIaconetti/software.html")
        
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
       
    }
        
    override func viewDidLoad(){
        super.viewDidLoad()
        
    }
    
}
