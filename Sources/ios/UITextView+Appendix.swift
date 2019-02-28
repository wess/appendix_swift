//
//  UITextView+Appendix.swift
//  Appendix
//
//  Created by Wesley Cope on 6/30/15.
//  Copyright (c) 2015 Wess Cope. All rights reserved.
//

import Foundation
import UIKit

public enum UITextViewPosition {
  case top
  case bottom
}

public extension UITextView {
  /// Number of lines text view contains.
  public var lineCount:Int {
    return Int(self.contentSize.height / self.font!.lineHeight)
  }
  
  /// Range of text that is currently visible in the text view.
  public var visibleTextRange:Range<Int> {
    let bounds:CGRect   = self.bounds
    let text            = self.text ?? ""
    let constraintSize  = CGSize(width: bounds.size.width, height: bounds.size.height)
    let size            = text.sizeConstrainted(to: constraintSize, font: self.font!)
    let start           = self.characterRange(at: bounds.origin)?.start
    let end             = self.closestPosition(to: CGPoint(x: size.width, y: size.height))
    let startingPoint   = self.offset(from: beginningOfDocument, to: start!)
    let endingPoint     = self.offset(from: start!, to: end!)
    
    return startingPoint..<endingPoint
  }

  /**
   Clear text.
   
   - returns: Current UITextView instance.
  */
  @discardableResult
  public func clear() -> UITextView {
    text            = ""
    attributedText  = NSAttributedString(string: "")
    
    return self
  }
  
  /**
   Scrolls to the top or the bottom.
   
   - parameter position: Location to scroll to (top or bottom).
   - returns: Current UITextView instance.
  */
  @discardableResult
  public func scroll(to position:UITextViewPosition) -> UITextView {
    let range:NSRange
    
    switch position {
    case .top:
      range = NSMakeRange(0, 1)
    case .bottom:
      range = NSMakeRange((self.text.count - 1), 1)
    }
    
    return self
  }
  
  /**
   Resize text view to the size of the content contained.
   
   - returns: Current UITextView instance.
  */
  @discardableResult
  public func sizeToContent() -> UITextView {
    contentInset                      = .zero
    scrollIndicatorInsets             = .zero
    contentOffset                     = .zero
    textContainerInset                = .zero
    textContainer.lineFragmentPadding = 0
    
    return self
  }
}
