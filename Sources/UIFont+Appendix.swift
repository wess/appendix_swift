//
//  UIFont+Appendix.swift
//  Appendix
//
//  Created by Wesley Cope on 7/28/15.
//  Copyright © 2015 Wess Cope. All rights reserved.
//

import Foundation

public extension UIFont {
  public func size(of string: String, constrainedToWidth width: Double) -> CGSize {
    return (string as NSString).boundingRect(with: CGSize(width: width, height: DBL_MAX),
                                             options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                             attributes: [NSFontAttributeName: self],
                                             context: nil).size
  }
}
