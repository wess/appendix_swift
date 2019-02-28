//
//  URLRequest+Appendix.swift
//  Appendix
//
//  Created by Wess Cope on 1/25/19.
//

import Foundation

extension URLRequest {
  public enum Method:String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
  }
  
  init(_ urlString:String, method:URLRequest.Method = .get) {
    self.init(url: URL(string: urlString)!)
    
    self.httpMethod = method.rawValue
  }

}
