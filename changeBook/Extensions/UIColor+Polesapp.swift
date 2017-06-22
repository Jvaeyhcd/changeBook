//
//  UIColor+Polesapp.swift
//  govlan
//
//  Created by polesapp-hcd on 16/8/19.
//  Copyright © 2016年 Polesapp. All rights reserved.
//

import Foundation

#if os(iOS) || os(tvOS)
    import UIKit
    typealias SWColor = UIColor
#else
    import Cocoa
    typealias SWColor = NSColor
#endif

private extension Int {
    func duplicate4bits() -> Int {
        return (self << 4) + self
    }
}

/// An extension of UIColor (on iOS) or NSColor (on OSX) providing HEX color handling.
public extension SWColor {
    /**
     Create non-autoreleased color with in the given hex string. Alpha will be set as 1 by default.
     - parameter hexString: The hex string, with or without the hash character.
     - returns: A color with the given hex string.
     */
    
    private convenience init?(hex3: Int, alpha: Float) {
        self.init(red:   CGFloat( ((hex3 & 0xF00) >> 8).duplicate4bits() ) / 255.0,
                  green: CGFloat( ((hex3 & 0x0F0) >> 4).duplicate4bits() ) / 255.0,
                  blue:  CGFloat( ((hex3 & 0x00F) >> 0).duplicate4bits() ) / 255.0, alpha: CGFloat(alpha))
    }
    
    private convenience init?(hex6: Int, alpha: Float) {
        self.init(red:   CGFloat( (hex6 & 0xFF0000) >> 16 ) / 255.0,
                  green: CGFloat( (hex6 & 0x00FF00) >> 8 ) / 255.0,
                  blue:  CGFloat( (hex6 & 0x0000FF) >> 0 ) / 255.0, alpha: CGFloat(alpha))
    }
    
    /**
     Create non-autoreleased color with in the given hex value. Alpha will be set as 1 by default.
     - parameter hex: The hex value. For example: 0xff8942 (no quotation).
     - returns: A color with the given hex value
     */
    public convenience init?(hex: Int) {
        self.init(hex: hex, alpha: 1.0)
    }
    
    /**
     Create non-autoreleased color with in the given hex value and alpha
     - parameter hex: The hex value. For example: 0xff8942 (no quotation).
     - parameter alpha: The alpha value, a floating value between 0 and 1.
     - returns: color with the given hex value and alpha
     */
    public convenience init?(hex: Int, alpha: Float) {
        if (0x000000 ... 0xFFFFFF) ~= hex {
            self.init(hex6: hex , alpha: alpha)
        } else {
            self.init()
            return nil
        }
    }
}
