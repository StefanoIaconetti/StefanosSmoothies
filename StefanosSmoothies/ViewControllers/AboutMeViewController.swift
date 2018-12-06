//
//  AboutMeViewController.swift
//  StefanosSmoothies
//
//  Created by Stefano Iaconetti on 2018-11-24.
//  Copyright © 2018 Stefano Iaconetti. All rights reserved.
//

//Imports
import Foundation
import UIKit
import CoreData
import UserNotifications

//This viewcontroller gives the user access to my portfolio website, ability to use notifications and has a picture of me
class AboutMeViewController: UIViewController{
    //Outlets connected via storyboard
    @IBOutlet weak var switchCheck: UISwitch!
    
    @IBOutlet var linkToWebsite: UIButton!
    
    @IBAction func goBack(_ sender: Any){
        dismiss(animated: true, completion: nil)
    }
    
    
    
    var hideAnimator: CustomModalHideAnimator?
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
                    print("error adding the notification - \(String(describing: error?.localizedDescription)) ")
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
        
        
        
        //Creates instance of CustomModalHideAnimator and binds the viewController
        hideAnimator = CustomModalHideAnimator(withViewController: self)
    }
    
}
