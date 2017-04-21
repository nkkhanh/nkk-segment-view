//
//  UILabelExtension.swift
//  NKKSegmentView
//
//  Created by Khanh Nguyen on 4/21/17.
//  Copyright © 2017 nkkhanh. All rights reserved.
//

import Foundation
import ObjectiveC
import UIKit

var UILabelAssociatedObjectHandle: UInt8 = 0

extension UILabel {
    
    var escapeFontSubstitution: Bool {
        get {
            return objc_getAssociatedObject(self, &UILabelAssociatedObjectHandle) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &UILabelAssociatedObjectHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var substituteAllFontName : String {
        get {
            return self.font.fontName
        }
        
        set {
            if self.escapeFontSubstitution == false && self.font.fontName.lowercased().range(of: "bold") == nil {
                self.font = UIFont(name: newValue, size: self.font.pointSize)
            }
        }
    }
    
    var substituteAllFontNameBold : String {
        get {
            return self.font.fontName
        }
        set {
            if self.escapeFontSubstitution == false && self.font.fontName.lowercased().range(of: "bold") != nil {
                self.font = UIFont(name: newValue, size: self.font.pointSize)
            }
        }
    }
    
    func format(){
        self.textColor = UIColor.green
        self.lineBreakMode = .byWordWrapping
        self.numberOfLines = 0
    }
    
    func formatSize(size: Int) {
        formatSizeInFloat(size: CGFloat(size))
    }
    
    func formatSizeInFloat(size: CGFloat) {
        self.format()
        self.font = UIFont(name: self.font.fontName, size: size)
    }
    
    func formatSizeBold(size: Int) {
        self.format()
        self.font = UIFont.boldSystemFont(ofSize: CGFloat(size))
    }
    
    func formatSmall() {
        self.formatSize(size: 14)
    }
    
    func formatSingleLine(fontSize: Int = 0) {
        self.textColor = UIColor.green
        self.adjustsFontSizeToFitWidth = true
        if fontSize != 0 {
            self.font = UIFont(name: self.font.fontName, size: CGFloat(fontSize))
        }
    }
    
    func formatError() {
        self.font = UIFont(name: self.font.fontName, size: CGFloat(14))
        self.lineBreakMode = .byWordWrapping
        self.numberOfLines = 0
        self.textColor = UIColor.white
        self.textAlignment = .center
    }
    
    func formatNote() {
        self.font = UIFont(name: self.font.fontName, size: CGFloat(11))
        self.textColor = UIColor.blue
        self.numberOfLines = 0
    }
    
    func optimumHeight(text: String? = nil, width: CGFloat) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = lineBreakMode
        label.font = font
        label.text = (text != nil) ? text! : self.text
        
        label.sizeToFit()
        
        return label.frame.height
    }
    
    //    func optimumWidth(text: String? = nil, height: CGFloat? = nil) -> CGFloat {
    //        let label = UILabel(frame: CGRectMake(0, 0, CGFloat.greatestFiniteMagnitude, (height != nil) ? height! : frame.height))
    //        label.numberOfLines = 1
    //        label.font = font
    //        label.text = (text != nil) ? text! : self.text
    //
    //        label.sizeToFit()
    //
    //        return label.frame.width
    //    }
    
    func addImage(imageName: String, afterLabel bolAfterLabel: Bool = false)
    {
        self.removeImage()
        let attachment: NSTextAttachment = NSTextAttachment()
        attachment.image = UIImage(named: imageName)
        if let image = attachment.image{
            attachment.bounds = CGRect(x: 0, y: -2.5, width: image.size.width, height: image.size.height)
        }
        let attachmentString: NSAttributedString = NSAttributedString(attachment: attachment)
        let spacing = NSAttributedString(string: " ")
        
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.lineBreakMode = .byTruncatingTail
        paraStyle.alignment = .center
        if (bolAfterLabel)
        {
            let strLabelText: NSMutableAttributedString = NSMutableAttributedString(string: self.text ?? "")
            strLabelText.append(spacing)
            strLabelText.append(attachmentString)
            strLabelText.addAttribute(NSParagraphStyleAttributeName, value: paraStyle, range: NSMakeRange(0, strLabelText.length))
            self.attributedText = strLabelText
        }
        else
        {
            let strLabelText: NSAttributedString = NSAttributedString(string: self.text ?? "")
            let mutableAttachmentString: NSMutableAttributedString = NSMutableAttributedString(attributedString: attachmentString)
            mutableAttachmentString.append(spacing)
            mutableAttachmentString.append(strLabelText)
            mutableAttachmentString.addAttribute(NSParagraphStyleAttributeName, value: paraStyle, range: NSMakeRange(0, mutableAttachmentString.length))
            self.attributedText = mutableAttachmentString
            
        }
    }
    
    func removeImage()
    {
        let text = self.text
        self.attributedText = nil
        self.text = text
    }
    
    func layoutInactiveOrOutOfStockLabel(forView view: UIView, sizePercentage: CGFloat) {
        let size = view.frame.width * sizePercentage
        self.frame = CGRect(x: 0, y: 0, width: size, height: size)
        self.center = view.center
        self.alpha = 0.7
        self.backgroundColor = UIColor.green
        self.textColor = UIColor.white
        self.textAlignment = .center
        self.font = UIFont.systemFont(ofSize: 14)
        self.text = ""
        
        // Circle mask
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.allCorners], cornerRadii: CGSize(width: size / 2, height: size / 2))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        self.layer.mask = shape
        
    }
}
