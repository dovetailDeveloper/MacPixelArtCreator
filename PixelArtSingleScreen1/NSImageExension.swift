//
//  NSImageExension.swift
//  PixelArtSingleScreen1
//
//  Created by Robert Steven Schwab on 11/15/16.
//  Copyright © 2016 Robert Steven Schwab. All rights reserved.
//

import Foundation
import CoreGraphics
import AppKit
import Cocoa

extension NSImage {
    func resizeImage(_ width: CGFloat, _ height: CGFloat) -> NSImage? {
        
        let representations = self.representations
        var bitmapRep: NSBitmapImageRep?
        
        for rep in representations {
            if let rep = rep as? NSBitmapImageRep {
                bitmapRep = rep
                break
            }
        }
        
        if bitmapRep == nil {
            return nil
        }
        
        let origWidth = CGFloat(bitmapRep!.pixelsWide)
        let origHeight = CGFloat(bitmapRep!.pixelsHigh)
        
        let aspect = CGFloat(origWidth) / CGFloat(origHeight)
        
        let targetWidth = width
        let targetHeight = height
        var newWidth: CGFloat
        var newHeight: CGFloat
        
        if 1 <= aspect {
            newWidth = targetWidth
            newHeight = newWidth / aspect
            
            if targetHeight < newHeight {
                newHeight = targetHeight
                newWidth = targetHeight * aspect
            }
        } else {
            newHeight = targetHeight
            newWidth = targetHeight * aspect
            
            if targetWidth < newWidth {
                newWidth = targetWidth
                newHeight = targetWidth / aspect
            }
        }
        
        if origWidth < newWidth {
            newWidth = origWidth
        }
        if origHeight < newHeight {
            newHeight = origHeight
        }
        
        let newImageRep = self.bestRepresentation(for: NSRect(x: 0, y: 0, width: newWidth, height: newHeight), context: nil, hints: nil)
        if newImageRep == nil {
            return nil
        }
        
        let thumbnail = NSImage(size: NSSize(width: newWidth, height: newHeight))
        thumbnail.addRepresentation(newImageRep!)
        
        return thumbnail
    }
}
