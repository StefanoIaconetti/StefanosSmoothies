//
//  CustomModalShowAnimator.swift
//  StefanosSmoothies
//
//  Created by Web on 2018-12-04.
//  Copyright © 2018 Stefano Iaconetti. All rights reserved.
//

import UIKit

class CustomModalShowAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    //Returns time interval which is the time we want to transition to last
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    //MARK:- animateTransition
    //Takes care of the actual animation for the custom transition
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //Grabs a reference to the target view controller
        guard let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else{return}
        
        //Grabs container view
        let transitionContainer = transitionContext.containerView
        
        //Setting up intial frame
        var transform = CGAffineTransform.identity
        transform = transform.concatenating(CGAffineTransform(scaleX: 0.6, y: 0.6))
        transform = transform.concatenating(CGAffineTransform(scaleX: 0, y: -200))
        
        //Setting alpha to 0
        toViewController.view.transform = transform
        toViewController.view.alpha = 0
        
        //adding the subview
        transitionContainer.addSubview(toViewController.view)
        
        //Creating the timing and animator
        let animationTiming = UISpringTimingParameters(dampingRatio: 0.8, initialVelocity: CGVector(dx: 1, dy: 0))
        let animator = UIViewPropertyAnimator(duration: transitionDuration(using: transitionContext), timingParameters: animationTiming)
        
        //Adding the animations
        animator.addAnimations {
            toViewController.view.transform = CGAffineTransform.identity
            toViewController.view.alpha = 1
        }
        
        animator.addCompletion {finished in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        animator.startAnimation()
    }
    
}
