//
//  CALayer+Appendix.swift
//  Appendix
//
//  Created by Wess Cope on 1/30/19.
//

import Foundation
import UIKit

public extension CAShapeLayer {
  convenience init(_ path:UIBezierPath) {
    self.init(path.cgPath)
  }

  convenience init(_ path:CGPath) {
    self.init()
    
    self.path = path
  }
}
