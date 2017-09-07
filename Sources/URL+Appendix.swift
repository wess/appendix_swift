//
//  URL+Appendix.swift
//  Appendix
//
//  Created by Wesley Cope on 8/11/17.
//  Copyright © 2017 Wess Cope. All rights reserved.
//

import Foundation

extension URL {
  public var components:URLComponents? {
    return URLComponents(string: self.absoluteString)
  }
  
  public var allQueryItems: [URLQueryItem] {
    get {
      guard let items = URLComponents(url: self, resolvingAgainstBaseURL: false)?.queryItems else {
        return []
      }
      
      return items as [URLQueryItem]
    }
  }

  public func queryItems(for key: String) -> [URLQueryItem]? {
    return allQueryItems.filter {$0.name == key}
  }

  public func queryItem(for key: String) -> URLQueryItem? {
    return queryItems(for: key)?.first
  }

  public func append(_ query:[String:Any]) -> URL? {
    let items:[URLQueryItem] = query.map {
      URLQueryItem(name: $0.key, value: "\($0.value)")
    }

    guard var components = self.components else { return nil }
    
    components.queryItems = (components.queryItems ?? []) + items
    
    return components.url
  }
  
  public func append(_ queryString: String = "") -> URL? {
    
    
    
    let urlString = absoluteString + "?\(queryString)"
    
    return URL(string: urlString)
  }
}

