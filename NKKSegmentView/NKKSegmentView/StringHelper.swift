//
//  StringHelper.swift
//  NKKSegmentView
//
//  Created by Khanh Nguyen on 4/21/17.
//  Copyright © 2017 nkkhanh. All rights reserved.
//

import UIKit

class StringHelper: NSObject {
    
    class func randomString(length: Int) -> String {
        
        //let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let letters : NSString = "abcdefghijklmnopqrstuvwxyz0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
    
    class func getTextWidth(text: String, height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
        let boundingBox = text.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        return boundingBox.width
    }
    
    class func getTextHeight(text: String, width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = text.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        return boundingBox.height
    }
    
    class func heightForView(text:String, font:UIFont, width:CGFloat, numberOfLines: Int) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = numberOfLines
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
    }
    
    class func formatPhoneNumber(phoneNumber: String) -> String {
        var characters = Array(phoneNumber.characters)
        let  max = 4
        
        for (index, _) in characters.enumerated() {
            if index > (max - 1 ) && index <= (max - 1 ) + max {
                characters[index] = "*"
            }
        }
        var result = ""
        for (_, element) in characters.enumerated() {
            result += String(element)
        }
        return result
    }
    
}
