//
//  UINavigationController+Appendix.swift
//  Appendix
//
//  Created by Wesley Cope on 6/30/15.
//  Copyright (c) 2015 Wess Cope. All rights reserved.
//

import Foundation
import UIKit

public extension UINavigationController {
    func pushViewController(controller:UIViewController, transition:UIViewAnimationTransition) {
        UIView.beginAnimations(nil, context: nil)
        
        self.pushViewController(controller, animated: false)
        
        UIView.setAnimationDuration(0.5)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationTransition(transition, forView: self.view, cache: true)
        UIView.commitAnimations()
    }

    func popViewControllerWithTransition(transition:UIViewAnimationTransition) -> UIViewController {
        UIView.beginAnimations(nil, context: nil)
        
        let controller:UIViewController = self.popViewControllerAnimated(false)!
        
        UIView.setAnimationDuration(0.5)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationTransition(transition, forView: self.view, cache: true)
        UIView.commitAnimations()
        
        return controller
    }
}