//
//  NSAttributedString+Appendix.swift
//  Appendix
//
//  Created by Wesley Cope on 12/12/16.
//  Copyright © 2016 Wess Cope. All rights reserved.
//

import Foundation
import UIKit

public extension NSAttributedString {
  public var bold:NSAttributedString {
    guard let copy  = mutableCopy() as? NSMutableAttributedString else { return self }
    let range       = NSMakeRange(0, string.length)
    
    copy.addAttributes([NSAttributedString.Key.font : UIFont.systemFontSize], range: range)
    return copy
  }

  public var underline: NSAttributedString {
    guard let copy  = mutableCopy() as? NSMutableAttributedString else { return self }
    let range       = NSMakeRange(0, string.length)

    copy.addAttributes([NSAttributedString.Key.font: NSUnderlineStyle.styleSingle.rawValue], range: range)
    return copy
  }

  public var italic: NSAttributedString {
    guard let copy  = mutableCopy() as? NSMutableAttributedString else { return self }
    let range       = NSMakeRange(0, string.length)

    copy.addAttributes([NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)], range: range)
    return copy
  }

  public var strikethrough: NSAttributedString {
    guard let copy  = mutableCopy() as? NSMutableAttributedString else { return self }
    let range       = NSMakeRange(0, string.length)
    let attributes  = [NSAttributedString.Key.strikethroughStyle: NSNumber(value: NSUnderlineStyle.styleSingle.rawValue as Int)]

    copy.addAttributes(attributes, range: range)
    return copy
  }
}

public extension NSAttributedString {
  public func color(_ color:UIColor) -> NSAttributedString {
    guard let copy  = mutableCopy() as? NSMutableAttributedString else { return self }
    let range       = NSMakeRange(0, string.length)

    copy.addAttributes([NSAttributedString.Key.foregroundColor: color], range: range)
    return copy
  }
}

public func += (lhs:inout NSAttributedString, rhs:NSAttributedString) {
  let mutant = NSMutableAttributedString(attributedString: lhs)
  mutant.append(rhs)

  lhs = mutant
}

public func + (lhs:NSAttributedString, rhs:NSAttributedString) -> NSAttributedString {
  let mutant = NSMutableAttributedString(attributedString: lhs)
  mutant.append(rhs)

  return NSAttributedString(attributedString: mutant)
}
