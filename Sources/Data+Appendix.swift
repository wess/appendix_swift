//
//  Data+Appendix.swift
//  Appendix
//
//  Created by Wesley Cope on 7/18/18.
//  Copyright (c) 2018 Wess Cope. All rights reserved.
//

import Foundation

public extension Data {
  public var bytes:[UInt8] {
    return [UInt8](self)
  }

  public var string:String? {
    return self.string()
  }

  public func string(_ encoding:String.Encoding = .utf8) -> String? {
    return String(data: self, encoding: encoding)
  }
}
