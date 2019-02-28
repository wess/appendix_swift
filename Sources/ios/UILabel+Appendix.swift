//
//  UILabel+Appendix.swift
//  Appendix
//
//  Created by Wesley Cope on 7/28/15.
//  Copyright © 2015 Wess Cope. All rights reserved.
//

import Foundation
import UIKit

public extension UILabel {
  
  public func suggestedSize(for width:CGFloat) -> CGSize {
    return suggestedSize(of:text ?? "", for: width)
  }
  
  public func suggestedSize(attributedString string:NSAttributedString, width:CGFloat) -> CGSize {
    if string.length < 1 {
      return .zero
    }
    
    return self.font.size(of: string.string, constrainedToWidth: Double(width))
  }
  
  public func suggestedSize(of string:String, for width:CGFloat) -> CGSize {
    return suggestedSize(attributedString: NSAttributedString(string: string), width: width)
  }
  
  public func height(for string:String, for width:CGFloat) -> CGFloat {
    return (string as NSString).boundingRect(
      with:       CGSize(width: width, height: CGFloat.greatestFiniteMagnitude),
      options:    NSStringDrawingOptions.usesLineFragmentOrigin,
      attributes: [NSAttributedString.Key.font: self.font.fontName],
      context:    nil
    ).height
  }
}


