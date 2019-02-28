//
//  IndexPath+Appendix.swift
//  Appendix
//
//  Created by Wess Cope on 2/6/19.
//

import Foundation

extension IndexPath {
  public static var zero:IndexPath {
    return IndexPath(row: 0, section: 0)
  }
  
  public init(_ index:Int) {
    self.init(row: index, section: index)
  }
}
