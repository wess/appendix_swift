//
//  UIFont+Appendix.swift
//  Appendix
//
//  Created by Wesley Cope on 7/28/15.
//  Copyright © 2017 Wess Cope. All rights reserved.
//

import Foundation

public extension UIFont {
  public func size(of string: String, constrainedToWidth width: Double) -> CGSize {
    return (string as NSString).boundingRect(with: CGSize(width: width, height: Double.greatestFiniteMagnitude),
                                             options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                             attributes: [NSAttributedStringKey.font: self],
                                             context: nil).size
  }
}
