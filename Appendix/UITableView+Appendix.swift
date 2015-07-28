//
//  UITableView+Appendix.swift
//  Appendix
//
//  Created by Wesley Cope on 7/28/15.
//  Copyright © 2015 Wess Cope. All rights reserved.
//

import Foundation

internal extension UITableView {
    func heightForCell(identifier:String, handler:((cell:AnyObject) -> Void)!) -> Float {
        var identifiers = [String:UITableViewCell]()
        var cell:UITableViewCell

        if identifiers[identifier] == nil {
            cell = dequeueReusableCellWithIdentifier(identifier)!
            
            identifiers[identifier] = cell
        }
        else {
            cell = identifiers[identifier]!
        }
        
        cell.contentView.bounds = CGRect(x: 0, y: 0, width: CGRectGetWidth(self.frame), height: self.rowHeight)
        
        cell.prepareForReuse()
        
        let constraint  = NSLayoutConstraint(item: cell.contentView, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: CGRectGetWidth(self.frame))
        
        cell.contentView.addConstraint(constraint)
        
        var size = cell.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
        
        cell.removeConstraint(constraint)
        
        if separatorStyle != UITableViewCellSeparatorStyle.None {
            size.height += 1 / UIScreen.mainScreen().scale
        }
        
        return Float(size.height)
    }
}