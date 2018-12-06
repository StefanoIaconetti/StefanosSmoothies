//
//  CustomModalHideAnimator.swift
//  StefanosSmoothies
//
//  Created by Stefano Iaconetti on 2018-12-04.
//  Copyright © 2018 Stefano Iaconetti. All rights reserved.
//

import UIKit

class CustomModalHideAnimator: UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning{
    let viewController: UIViewController
    
    //Custom initializer
    //MARK:- initializer
    init(withViewController viewController: UIViewController) {
        //Ties viewcontroller to itself
        self.viewController = viewController
        
        //Calls superclass initializer
        super.init()
        
        //Pangesture is added
        let panGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleEdgePan(gestureRecognizer:)))
        
        panGesture.edges = .left
        viewController.view.addGestureRecognizer(panGesture)
    }
    //MARK:- Functions
    //Finds the distance that is swiped
    @objc func handleEdgePan(gestureRecognizer: UIScreenEdgePanGestureRecognizer){
        let panTranslation = gestureRecognizer.translation(in: viewController.view)
        let animationProgress = min(max(panTranslation.x / 200,0.0), 1.0)
        
        //Switch case the state of the gesture
        switch gestureRecognizer.state{
        case .began:
            viewController.dismiss(animated: true, completion: nil)
        case .changed:
            update(animationProgress)
            break
        case .ended:
            if animationProgress < 0.5 {
                cancel()
            }else{
                finish()
            }
            break
        default:
            cancel()
            break
        }
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?)->
        TimeInterval {
            return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from), let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
            return
        }
        //Creates the transitionContainer by grabbing the context
        let transitionContainer = transitionContext.containerView
        
        transitionContainer.addSubview(toViewController.view)
        transitionContainer.addSubview(fromViewController.view)
        //Setting animationTiming
        let animationTiming = UISpringTimingParameters(dampingRatio: 0.8, initialVelocity: CGVector(dx: 1, dy:0))
        
        let animator = UIViewPropertyAnimator(duration: transitionDuration(using: transitionContext), timingParameters: animationTiming)
        //Adding animations
        animator.addAnimations {
            var transform = CGAffineTransform.identity
            transform = transform.concatenating(CGAffineTransform(scaleX: 0.6, y: 0.6))
            transform = transform.concatenating(CGAffineTransform(translationX: 0, y: -200))
            
            fromViewController.view.transform = transform
            
            fromViewController.view.alpha = 0
        }
        //Completing the animation
        animator.addCompletion{finished in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        //Starting animation
        animator.startAnimation()
    }
}
