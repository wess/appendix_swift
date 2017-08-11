//
//  Int+Appendix.swift
//  Appendix
//
//  Created by Wesley Cope on 8/11/17.
//  Copyright © 2017 Wess Cope. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem {
  convenience init(_ systemItem: UIBarButtonSystemItem, target: Any? = nil, action: Selector? = nil) {
    self.init(systemItem, target: target, action: action)
  }
}

let UIBarButtonFlexibleItem   = UIBarButtonItem(.flexibleSpace)
let UIBarButtonFixedSpaceItem = UIBarButtonItem(.fixedSpace)
