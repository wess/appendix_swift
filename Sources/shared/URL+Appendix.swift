//
//  URL+Appendix.swift
//  Appendix
//
//  Created by Wesley Cope on 8/11/17.
//  Copyright © 2017 Wess Cope. All rights reserved.
//

import Foundation

extension URL {
  
  /// URL Components
  public var components:URLComponents? {
    return URLComponents(string: self.absoluteString)
  }
  
  /// Query items of the current URL.
  public var allQueryItems: [URLQueryItem] {
    get {
      guard let items = URLComponents(url: self, resolvingAgainstBaseURL: false)?.queryItems else {
        return []
      }
      
      return items as [URLQueryItem]
    }
  }

  /// Dictionary representation of query items.
  public var params: [String:String]? {
    return allQueryItems.reduce([String:String]()) {
      var dict = $0
      dict[$1.name] = $1.value
      
      return dict
    }
  }

  /**
   Retrive all query items for a specific key.
   
   - parameter key: Identifier that represents a value within the query items.
   - returns: List of query items or nil if none present.
  */
  public func queryItems(for key: String) -> [URLQueryItem]? {
    return allQueryItems.filter {$0.name == key}
  }

  /**
   Retrive a query item for a specific key.
   
   - parameter key: Identifier that represents a value within the query items.
   - returns: Value of query item or nil if none present.
   */
  public func queryItem(for key: String) -> URLQueryItem? {
    return queryItems(for: key)?.first
  }

  /**
   Appends a query item to the end of the url.
   
   - parameter query: Dictionary to convert to query and append.
   - returns: Updated URL with additional query items appended.
  */
  public func append(_ query:[String:Any]) -> URL? {
    let items:[URLQueryItem] = query.map {
      URLQueryItem(name: $0.key, value: "\($0.value)")
    }

    guard var components = self.components else { return nil }
    
    components.queryItems = (components.queryItems ?? []) + items
    
    return components.url
  }
  
  /**
   Append a query string to the end of the URL.
   
   - parameter queryString: String to append to the end of the url.
   - returns: Updated url with query string appended.
  */
  public func append(_ queryString: String) -> URL? {
    let urlString = absoluteString + "?\(queryString)"
    
    return URL(string: urlString)
  }
  
  /**
   Subscript access to a URL's query items.
   
   - parameter key: Identifier that represents a value within the query items.
  */
  public subscript(key:String) -> Any? {
    get {
      return queryItem(for: key)
    }
    
    set {
      guard let value = newValue else { return }
      
      append([key : value])
    }
  }
}

