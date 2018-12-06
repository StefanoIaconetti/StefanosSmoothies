//
//  ViewEffectAnimatorType.swift
//  StefanosSmoothies
//
//  Created by Stefano iaconetti on 2018-12-04.
//  Copyright © 2018 Stefano Iaconetti. All rights reserved.
//

import UIKit

typealias ViewEffectAnimatorComplete = (UIViewAnimatingPosition) -> Void

//Allows us to use the same handler type across app
protocol ViewEffectAnimatorType {
    var animator: UIViewPropertyAnimator { get}
    init(targetView: UIView, onComplete:@escaping ViewEffectAnimatorComplete)
    init(targetView: UIView, onComplete: @escaping ViewEffectAnimatorComplete, duration: TimeInterval)
    
    func startAnimation()
}

//calls the startAnimation function
extension ViewEffectAnimatorType {
    func startAnimation(){
        animator.startAnimation()
    }
}
