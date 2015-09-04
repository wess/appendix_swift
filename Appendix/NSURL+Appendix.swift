//
//  NSURL+Appendix.swift
//  Appendix
//
//  Created by Wesley Cope on 7/16/15.
//  Copyright © 2015 Wess Cope. All rights reserved.
//

import Foundation

public extension NSURL {
    public func append(queryString: String = "") -> NSURL {
        let urlString = self.absoluteString + "?\(queryString)"
        
        return NSURL(string: urlString)!
    }
}