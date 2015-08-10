//
//  CGRect+Appendix.swift
//  Appendix
//
//  Created by Wesley Cope on 8/10/15.
//  Copyright © 2015 Wess Cope. All rights reserved.
//

import Foundation



extension CGPoint {
    init(_ x: CGFloat, _ y: CGFloat) {
        self.x = x
        self.y = y
    }
    
    func with(x x:CGFloat) -> CGPoint {
        return CGPoint(x: x, y: y)
    }
    
    func with(y y:CGFloat) -> CGPoint {
        return CGPoint(x: x, y: y)
    }
}

extension CGRect {
    var x:CGFloat {
        get { return origin.x }
        set { origin.x = newValue }
    }
    
    var y:CGFloat {
        get { return origin.y }
        set { origin.y = newValue }
    }

    var top:CGFloat {
        get { return y }
        set { y = newValue }
    }

    var right:CGFloat {
        get { return x + width }
        set { x = newValue - width }
    }
    
    var bottom:CGFloat {
        get { return y + height }
        set { y = newValue - height }
    }
    
    var left:CGFloat {
        get { return x }
        set { x = newValue }
    }
    
    var centerX:CGFloat {
        get { return x + width * 0.5  }
        set { x = newValue - width * 0.5 }
    }

    var centerY:CGFloat {
        get { return y + width * 0.5 }
        set { y = newValue - width * 0.5 }
    }
    
    var center:CGPoint {
        get { return CGPoint(x, y) }
        set {
            centerX = newValue.x
            centerY = newValue.y
        }
    }
}



