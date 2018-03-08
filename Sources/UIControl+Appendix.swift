//
//  UIControl+Appendix.swift
//  Appendix
//
//  Created by Wess Cope on 3/8/18.
//

import Foundation
import UIKit

public extension UIControl {
  @discardableResult
  public func focus() -> Bool {
    return becomeFirstResponder()
  }
  
  public func unfocus(){
    resignFirstResponder()
  }
}
