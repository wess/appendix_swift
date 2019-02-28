
//
//  UITableView+Appendix.swift
//  Appendix
//
//  Created by Wesley Cope on 7/28/15.
//  Copyright © 2015 Wess Cope. All rights reserved.
//

import Foundation
import UIKit

public extension UITableView {
  
  /**
   Calculates the height for the current cell.
   
   - parameter identifier: Identifies the cell contained in the table.
   - parameter handler: Block called for setting up current cell.
   - returns: Calculated height of cell for content.
  */
  public func heightForCell(identifier:String, handler:((_ cell:AnyObject) -> Void)!) -> CGFloat {
    var identifiers = [String:UITableViewCell]()
    var cell:UITableViewCell
    
    if identifiers[identifier] == nil {
      cell = dequeueReusableCell(withIdentifier: identifier)!
      
      identifiers[identifier] = cell
    }
    else {
      cell = identifiers[identifier]!
    }
    
    handler(cell)
    
    cell.contentView.bounds = CGRect(x: 0, y: 0, width: self.frame.width, height: self.rowHeight)
    
    cell.prepareForReuse()
    
    let constraint = NSLayoutConstraint(
      item:       cell.contentView,
      attribute:  .width,
      relatedBy:  .equal,
      toItem:     nil,
      attribute:  .notAnAttribute,
      multiplier: 1,
      constant:   self.frame.width
    )
    
    cell.contentView.addConstraint(constraint)
    
    var size = cell.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    
    cell.removeConstraint(constraint)
    
    if separatorStyle != UITableViewCell.SeparatorStyle.none {
      size.height += 1 / UIScreen.main.scale
    }
    
    return CGFloat(size.height)
  }
}
