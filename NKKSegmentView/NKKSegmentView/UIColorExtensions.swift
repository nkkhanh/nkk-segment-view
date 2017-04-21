//
//  UIColorExtensions.swift
//  NKKSegmentView
//
//  Created by Khanh Nguyen on 4/21/17.
//  Copyright © 2017 nkkhanh. All rights reserved.
//

import UIKit

import UIKit
extension UIColor {
    
    convenience init(argb: UInt) {
        self.init(
            red: CGFloat((argb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((argb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(argb & 0x0000FF) / 255.0,
            alpha: CGFloat((argb & 0xFF000000) >> 24) / 255.0
        )
    }
    convenience init(rgb: UInt) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: 1.0
        )
    }
}
