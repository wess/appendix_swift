//
//  UIBarButtonItem+Appendix.swift
//  Appendix
//
//  Created by Wess Cope on 2/12/19.
//

import Foundation
import UIKit

public extension UIBarButtonItem {
  public class var flexibleSpace:UIBarButtonItem {
    return UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
  }

  public class var fixedSpace:UIBarButtonItem {
    return UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
  }
}
