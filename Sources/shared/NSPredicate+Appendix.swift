//
//  NSPredicate+Appendix.swift
//  Appendix
//
//  Created by Wesley Cope on 9/18/18.
//  Copyright © 2018 Wess Cope. All rights reserved.
//

import Foundation

public extension NSPredicate {
  public var not:NSCompoundPredicate {
    return NSCompoundPredicate(notPredicateWithSubpredicate: self)
  }

 	public func and(_ predicate: NSPredicate) -> NSCompoundPredicate {
		return NSCompoundPredicate(andPredicateWithSubpredicates: [self, predicate])
	}

	public func or(_ predicate: NSPredicate) -> NSCompoundPredicate {
		return NSCompoundPredicate(orPredicateWithSubpredicates: [self, predicate])
	} 

  	static public prefix func ! (rhs: NSPredicate) -> NSCompoundPredicate {
		return rhs.not
	}

	static public func + (lhs: NSPredicate, rhs: NSPredicate) -> NSCompoundPredicate {
		return lhs.and(rhs)
	}
	static public func | (lhs: NSPredicate, rhs: NSPredicate) -> NSCompoundPredicate {
		return lhs.or(rhs)
	}

	static public func - (lhs: NSPredicate, rhs: NSPredicate) -> NSCompoundPredicate {
		return lhs + !rhs
	}
}
