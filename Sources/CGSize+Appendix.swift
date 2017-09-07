//
//  CGSize+Appendix.swift
//  Appendix
//
//  Created by Wess Cope on 8/11/17.
//
//

import Foundation
import UIKit

extension CGSize {
  public init(_ size:CGFloat) {
    self.init(width: size, height: size)
  }
  
  public init(width:CGFloat) {
    self.init(width: width, height: 0)
  }
  
  public init(height:CGFloat) {
    self.init(width: 0, height: height)
  }
}
