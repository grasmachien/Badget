//
//  extensionTImer.swift
//  badgetMAIV
//
//  Created by Matthias Brodelet on 6/06/15.
//  Copyright (c) 2015 Brodelet.Matthias. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    var highestQualityJPEGNSData:NSData { return UIImageJPEGRepresentation(self, 1.0) }
    var highQualityJPEGNSData:NSData    { return UIImageJPEGRepresentation(self, 0.75)}
    var mediumQualityJPEGNSData:NSData  { return UIImageJPEGRepresentation(self, 0.5) }
    var lowQualityJPEGNSData:NSData     { return UIImageJPEGRepresentation(self, 0.25)}
    var lowestQualityJPEGNSData:NSData  { return UIImageJPEGRepresentation(self, 0.0) }
}


extension NSTimer {
    /**
    Creates and schedules a one-time `NSTimer` instance.
    
    :param: delay The delay before execution.
    :param: handler A closure to execute after `delay`.
    
    :returns: The newly-created `NSTimer` instance.
    */
    class func schedule(#delay: NSTimeInterval, handler: NSTimer! -> Void) -> NSTimer {
        let fireDate = delay + CFAbsoluteTimeGetCurrent()
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, 0, 0, 0, handler)
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, kCFRunLoopCommonModes)
        return timer
    }
    
    /**
    Creates and schedules a repeating `NSTimer` instance.
    
    :param: repeatInterval The interval between each execution of `handler`. Note that individual calls may be delayed; subsequent calls to `handler` will be based on the time the `NSTimer` was created.
    :param: handler A closure to execute after `delay`.
    
    :returns: The newly-created `NSTimer` instance.
    */
    class func schedule(repeatInterval interval: NSTimeInterval, handler: NSTimer! -> Void) -> NSTimer {
        let fireDate = interval + CFAbsoluteTimeGetCurrent()
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, interval, 0, 0, handler)
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, kCFRunLoopCommonModes)
        return timer
}
}

extension Int
{
    static func random(range: Range<Int> ) -> Int
    {
        var offset = 0
        
        if range.startIndex < 0   // allow negative ranges
        {
            offset = abs(range.startIndex)
        }
        
        let mini = UInt32(range.startIndex + offset)
        let maxi = UInt32(range.endIndex   + offset)
        
        return Int(mini + arc4random_uniform(maxi - mini)) - offset
    }
}

extension Range
{
    var randomInt: Int
        {
        get
        {
            var offset = 0
            
            if (startIndex as! Int) < 0   // allow negative ranges
            {
                offset = abs(startIndex as! Int)
            }
            
            let mini = UInt32(startIndex as! Int + offset)
            let maxi = UInt32(endIndex   as! Int + offset)
            
            return Int(mini + arc4random_uniform(maxi - mini)) - offset
        }
    }
}

