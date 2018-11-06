//
//  ViewController.swift
//  StefanosSmoothies
//
//  Created by Stefano Iaconetti on 2018-11-05.
//  Copyright © 2018 Stefano Iaconetti. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.indicator.isHidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

