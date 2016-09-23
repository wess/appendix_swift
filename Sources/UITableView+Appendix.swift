
//
//  UITableView+Appendix.swift
//  Appendix
//
//  Created by Wesley Cope on 7/28/15.
//  Copyright © 2015 Wess Cope. All rights reserved.
//

import Foundation

public extension UITableView {
    public func heightForCell(identifier:String, handler:((_ cell:AnyObject) -> Void)!) -> Float {
        var identifiers = [String:UITableViewCell]()
        var cell:UITableViewCell

        if identifiers[identifier] == nil {
            cell = dequeueReusableCell(withIdentifier: identifier)!
            
            identifiers[identifier] = cell
        }
        else {
            cell = identifiers[identifier]!
        }
        
        cell.contentView.bounds = CGRect(x: 0, y: 0, width: self.frame.width, height: self.rowHeight)
        
        cell.prepareForReuse()
        
        let constraint  = NSLayoutConstraint(item: cell.contentView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: self.frame.width)
        
        cell.contentView.addConstraint(constraint)
        
        var size = cell.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        
        cell.removeConstraint(constraint)
        
        if separatorStyle != UITableViewCellSeparatorStyle.none {
            size.height += 1 / UIScreen.main.scale
        }
        
        return Float(size.height)
    }
}
