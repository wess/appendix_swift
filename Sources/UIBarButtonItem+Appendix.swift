//
//  UIBarButtonItem+Appendix.swift
//  Appendix
//
//  Created by Wess Cope on 3/8/18.
//

import Foundation
import UIKit

public extension UIBarButtonItem {
  public static var flexibleSpace:UIBarButtonItem {
    return UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
  }
  
  public static var fixedSpace:UIBarButtonItem {
    return UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
  }
}
