//
//  Pipes.swift
//  Appendix
//
//  Created by Wess Cope on 7/17/18.
//

import Foundation

precedencegroup PrecedencePipeLeft {
  associativity:  right
  higherThan:     NilCoalescingPrecedence
  lowerThan:      RangeFormationPrecedence
}

precedencegroup PrecedencePipeRight {
  associativity:  left
  higherThan:     NilCoalescingPrecedence
  lowerThan:      RangeFormationPrecedence
}

infix operator <| : PrecedencePipeLeft
infix operator |> : PrecedencePipeRight

public func <|<A,Z>(lhs:(A) -> Z, rhs: A) -> Z {
  return lhs(rhs)
}

public func |><A,Z>(lhs:A, rhs:(A) -> Z) -> Z {
  return rhs(lhs)
}
