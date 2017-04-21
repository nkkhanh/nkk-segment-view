//
//  NKKCustomeCell.swift
//  NKKSegmentView
//
//  Created by Khanh Nguyen on 4/21/17.
//  Copyright © 2017 nkkhanh. All rights reserved.
//


import Foundation
import UIKit

enum NKKPositon : Int {
    case left = 0
    case middle
    case right
}

class NKKCustomeCell : UICollectionViewCell {
    var label = UILabel()
    var imageView = UIImageView()
    var position: NKKPositon = .middle
    var isChose = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        
        imageView.clipsToBounds = true
        addSubview(imageView)
        
        label.textAlignment = .center
        label.backgroundColor = UIColor.clear
        contentView.addSubview(label)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: 0, y: bounds.height - 7, width: bounds.width, height: 1)
        label.frame = bounds
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func updatUI(){
//        switch position {
//        case .left:
//            self.backgroundColor = UIColor.white
//        case .right:
//            self.backgroundColor = UIColor.blue
//        case .middle:
//            self.backgroundColor = UIColor.red
//        default:
//            break
//        }
        
        if label.textColor == UIColor.white {
            self.backgroundColor = UIColor.red
        } else {
            self.backgroundColor = UIColor.white
            
        }
    }
}
