//
//  NKKCustomeCell.swift
//  NKKSegmentView
//
//  Created by Khanh Nguyen on 4/21/17.
//  Copyright © 2017 nkkhanh. All rights reserved.
//


import Foundation
import UIKit

class NKKCustomeCell : UICollectionViewCell {
    var label = UILabel()
    var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.black
        
        imageView.clipsToBounds = true
        addSubview(imageView)
        
        label.textAlignment = .center
        label.backgroundColor = UIColor.white
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
}
