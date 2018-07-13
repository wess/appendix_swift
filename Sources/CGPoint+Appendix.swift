//
//  CGPoint+Appendix.swift
//  Appendix
//
//  Created by Wess Cope on 8/11/17.
//
//

import Foundation
import UIKit

extension CGPoint {
  public init(_ coord:CGFloat) {
    self.init(x: coord, y: coord)
  }
  
  public init(x:CGFloat) {
    self.init(x, 0)
  }

  public init(y:CGFloat) {
    self.init(0, y)
  }
}
