//
//  console.swift
//  appendix
//
//  Created by Wess Cope on 9/25/18.
//

import Foundation

struct console {
  private static let infoCharacter    = "ℹ️"
  private static let debugCharacter   = "🐞"
  private static let successCharacter = "✅"
  private static let warningCharacter = "⚠️"
  private static let errorCharacter   = "❗️"
  private static let fatalCharacter   = "‼️"
  
  static let log = console.info
  
  static func info(_ args:Any..., line:Int = #line, file:String = #file, function:String = #function) {
    console.safePrint(
      (infoCharacter + " \(line) : \((file.split(separator: "/").last ?? "")) : \(function) :: " + buildMessage(args))
    )
  }
  
  static func debug(_ args:Any..., line:Int = #line, file:String = #file, function:String = #function) {
    console.safePrint(
      (debugCharacter + " \(line) : \((file.split(separator: "/").last ?? "")) : \(function) :: " + buildMessage(args))
    )
  }
  
  static func success(_ args:Any..., line:Int = #line, file:String = #file, function:String = #function) {
    console.safePrint(
      (successCharacter + " \(line) : \((file.split(separator: "/").last ?? "")) : \(function) :: " + buildMessage(args))
    )
  }
  
  static func warning(_ args:Any..., line:Int = #line, file:String = #file, function:String = #function) {
    console.safePrint(
      (warningCharacter + " \(line) : \((file.split(separator: "/").last ?? "")) : \(function) :: " + buildMessage(args))
    )
  }
  
  static func error(_ args:Any..., line:Int = #line, file:String = #file, function:String = #function) {
    console.safePrint(
      (errorCharacter + " \(line) : \((file.split(separator: "/").last ?? "")) : \(function) :: " + buildMessage(args))
    )
  }
  
  private static func buildMessage(_ args:[Any]) -> String {
    let parts = args.map { part in
      return "\(part)"
    }
    
    return parts.joined(separator: " ")
  }
  
  private static func safePrint(_ message:String) {
    #if DEBUG
    
    print(message)
    
    #endif
  }
}
