//
//  NSImage+Appendix.swift
//  Appendix
// 
//  Created by Wess Cope (me@wess.io) on 01/24/19
//  Copyright 2018 Wess Cope
//

import Foundation
import Cocoa
import CoreGraphics

extension NSImage {
  func drawAsTemplateInRect(rect:NSRect, in view:NSView, highlighted:Bool, enabled:Bool) {
    let dropShadowOffsetY:CGFloat       = -1.0
    let innerShadowBlurRadius:CGFloat   = 1.0
    
    guard let graphicsContext = NSGraphicsContext.current else { return }

    let context:CGContext = graphicsContext.cgContext
    
    graphicsContext.saveGraphicsState()
    
    let deviceRect    = context.convertToDeviceSpace(rect)
    let scale:CGFloat = deviceRect.height / rect.height
    
    if graphicsContext.isFlipped {
      context.translateBy(x: 0.0, y: view.frame.height)
      context.scaleBy(x: 1.0, y: -1.0)
    }
    
    var maskRect    =  rect
    let maskImage   = cgImage(forProposedRect: &maskRect, context: graphicsContext, hints: nil)!
    
    context.setShadow(offset: CGSize(width: 0.0, height:dropShadowOffsetY), blur: 0)
    
    let drawFrame = NSRect(x: 0, y: 0, width: size.width, height: size.height)
    draw(in: maskRect, from: drawFrame, operation: NSCompositingOperation.sourceOver, fraction: 0.5)
    
    context.clip(to: maskRect, mask: maskImage)
    
    let startColor:NSColor  = highlighted ? NSColor(calibratedRed: 0.0, green: 0.55, blue: 0.98, alpha: 1.0) : NSColor(deviceWhite: 0.33, alpha: 1.0)
    let endColor:NSColor    = highlighted ? NSColor(calibratedRed: 0.0, green: 0.15, blue: 0.75, alpha: 1.0) : NSColor(deviceWhite: 0.46, alpha: 1.0)
    let gradient            = NSGradient(starting: startColor, ending: endColor)
    
    gradient?.draw(in: maskRect, angle: 90.0)
    
    context.setShadow(offset: CGSize(width:0, height: -1), blur: innerShadowBlurRadius, color: NSColor(calibratedWhite: 0.1, alpha: 0.75).cgColor)
    
    let cgRect = CGRect(x: 0.0, y: 0.0, width: maskRect.width * scale, height: maskRect.height * scale)
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    let maskContext = CGContext(data: nil, width: Int(deviceRect.size.width), height: Int(deviceRect.size.height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
    
    maskContext.setBlendMode(.xor)
    maskContext.draw(maskImage, in: cgRect)
    maskContext.setFillColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    maskContext.fill(cgRect)
    
    let invertedMaskImage = maskContext.makeImage()
    
    context.draw(invertedMaskImage!, in: maskRect)
    
    graphicsContext.restoreGraphicsState()
  }
  
  func resize(to:CGSize) -> NSImage? {
    let result = NSImage(size: to)
    
    result.lockFocus()
    
    let toRect    = CGRect(x: 0, y: 0, width: to.width, height: to.height)
    let fromRect  = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    
    result.draw(in: toRect, from: fromRect, operation: .sourceOver, fraction: 1.0)
    
    result.unlockFocus()
    
    result.size = to
    
    return NSImage(data: result.tiffRepresentation!)!
  }
}
