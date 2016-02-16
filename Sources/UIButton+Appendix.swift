//
//  UIButton+Appendix.swift
//  Appendix
//
//  Created by Wesley Cope on 1/13/16.
//  Copyright © 2016 Wess Cope. All rights reserved.
//

import Foundation
import UIKit

private var ANNEX_BUTTON_BACKGROUNDCOLORS:UInt8 = 0


public extension UIButton {
    var backgroundColors:[UInt:UIColor]? {
        get {
            return (objc_getAssociatedObject(self, &ANNEX_BUTTON_BACKGROUNDCOLORS) as? [UInt:UIColor])
        }
        
        set {
            objc_setAssociatedObject(self, &ANNEX_BUTTON_BACKGROUNDCOLORS, backgroundColors, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    public func setBackgroundColor(color:UIColor, state:UIControlState) {
        if var backgroundColors = backgroundColors {
            backgroundColors[state.rawValue] = color
        }
        else {
            backgroundColors = [state.rawValue: color]
        }
    }
    
    private func animateBackgroundColor(key:UInt) {
        guard let backgroundColors = backgroundColors else { return }
        
        if let color = backgroundColors[key] {
            UIView.animateWithDuration(0.1) {
                self.backgroundColor = color
            }
        }
    }
    
    //MARK: - Touches
    public override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
        animateBackgroundColor(UIControlState.Highlighted.rawValue)
    }
    
    public override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        super.touchesCancelled(touches, withEvent: event)
        
        animateBackgroundColor(UIControlState.Normal.rawValue)
    }
    
    public override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        
        animateBackgroundColor(UIControlState.Normal.rawValue)
    }
}
