//
//  ViewController.swift
//  StefanosSmoothies
//
//  Created by Stefano Iaconetti on 2018-11-05.
//  Copyright © 2018 Stefano Iaconetti. All rights reserved.
//

import UIKit

class SplashScreen: UIViewController {
    
    @IBOutlet var contButton: UIButton!
    @IBOutlet var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contButton.isHidden = true
        contButton.layer.cornerRadius = 4
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.indicator.isHidden = true
            self.contButton.isHidden = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

