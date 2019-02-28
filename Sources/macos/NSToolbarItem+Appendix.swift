//
//  NSToolbarItem+Appendix.swift
//  Appendix
// 
//  Created by Wess Cope (me@wess.io) on 01/24/19
//  Copyright 2018 Wess Cope
//

import Foundation
import Cocoa

extension NSToolbarItem {
  convenience init(itemIdentifier: String) {
    self.init(itemIdentifier: NSToolbarItem.Identifier(itemIdentifier))
  }
}
