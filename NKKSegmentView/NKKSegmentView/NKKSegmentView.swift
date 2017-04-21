//
//  NKKSegmentView.swift
//  NKKSegmentView
//
//  Created by Khanh Nguyen on 4/21/17.
//  Copyright © 2017 nkkhanh. All rights reserved.
//

import UIKit

protocol NKKSegmentViewDelegate: NSObjectProtocol {
    func didSelectTabAtIndex(tabIndex : Int)
}
class NKKSegmentView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var subCatCollectionView : UICollectionView!
    private var arrayTabs = [String]()
    var selectingTab : Int = 0
    weak var delegate: NKKSegmentViewDelegate?
    private final let CatCellSpacing : CGFloat = 0
    private final let IndicatorOffset : CGFloat = 0
    private final let BottomPadding : CGFloat = 3
    private final let CellHeight : CGFloat = 50
    private final let FontSize : Int = 14
    private var marginLeft = CGFloat(0)
    private var tabLabel = UILabel()
    
    private final var indicatorView = UIView()
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, tabs: [String]) {
        self.init(frame: frame)
        self.backgroundColor = UIColor.white
        arrayTabs = tabs
        tabLabel.formatSize(size: FontSize)
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: frame.width, height: bounds.height)
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        subCatCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: frame.width, height: CellHeight), collectionViewLayout: layout)
        subCatCollectionView.register(NKKCustomeCell.self, forCellWithReuseIdentifier: "NKKCustomeCell")
        subCatCollectionView.backgroundColor = UIColor.white
        subCatCollectionView.showsHorizontalScrollIndicator = false
        subCatCollectionView.delegate = self
        subCatCollectionView.dataSource = self
        addSubview(subCatCollectionView)
        //indicatorView.borderColor = UIColor.red.cgColor
        //indicatorView.borderWidth = 1
        indicatorView.backgroundColor = UIColor.red
        //self.addSubview(indicatorView)
        //sendSubview(toBack: indicatorView)
        marginLeft = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(array: [String]) {
        arrayTabs = array
        self.refreshUI()
    }
    func refreshUI(){
        self.subCatCollectionView.reloadData()
        self.updateIndicatorView()
    }
    
    //MARK: CollectionView Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayTabs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NKKCustomeCell", for: indexPath) as! NKKCustomeCell
        cell.label.text = arrayTabs[indexPath.row]
        cell.label.formatSize(size: FontSize)
        
        cell.isChose = false
        if selectingTab == indexPath.row {
           // cell.label.font = UIFont(name: "SourceSansPro-Semibold", size: 16)
            //cell.label.textColor = UIColor(rgb: 0xc90000)
            cell.label.textColor = UIColor.white
            cell.isChose = true
        } else {
          //  cell.label.font = UIFont(name: "SourceSansPro-Regular", size: 16)
            cell.label.textColor = UIColor(rgb: 0x767676)
        }
        cell.imageView.isHidden = true
        //cell.backgroundColor = UIColor.green
        let lastIndex = arrayTabs.count - 1
        switch indexPath.row {
        case 0:
            cell.position = .left
        case lastIndex:
            cell.position = .right
        default:
            cell.position = .middle
        }
        cell.updatUI()
        return cell
    }
    
    //MARK: - Collection Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return  CatCellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return  CatCellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, marginLeft, 0, marginLeft)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWith = ceil((bounds.width - marginLeft * 2) / CGFloat(arrayTabs.count))
        return CGSize(width: cellWith, height: CellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.selectingTab != indexPath.row {
            self.delegate?.didSelectTabAtIndex(tabIndex: indexPath.row)
            
            self.setSelectedTab(tabIndex: indexPath.row)
        }
    }
    
    func getCellPostX(index: Int) -> CGFloat {
        let textWidth = StringHelper.getTextWidth(text: arrayTabs[index], height: CellHeight, font: tabLabel.font)
        let cellWidth = (bounds.width - marginLeft * 2) / CGFloat(arrayTabs.count)
        var indicatorWidth = textWidth + IndicatorOffset * 2
        if indicatorWidth > cellWidth {
            indicatorWidth = cellWidth
        }
        let postX = marginLeft + CGFloat(index) * cellWidth + (cellWidth - indicatorWidth) / 2
        return postX
    }
    
    func updateIndicatorView() {
        
        let cellWidth = (bounds.width - marginLeft * 2) / CGFloat(arrayTabs.count)
        let postX = marginLeft + CGFloat(self.selectingTab) * cellWidth
        
        //indicatorLayer.frame = CGRect(x: postX, y: bounds.height - BottomPadding, width: cellWidth, height: 3)
        indicatorView.frame = CGRect(x: postX, y: 0, width: cellWidth, height: bounds.height)
        self.layoutIfNeeded()
        self.setNeedsLayout()
        //        CGRectMake(postX, bounds.height - BottomPadding, indicatorWidth, 1)
    }
    
    func getMarginLeft() -> CGFloat{
        if arrayTabs.count < 2 || arrayTabs.count > 5 {
            return 0
        }
        let tabCount = CGFloat(arrayTabs.count) //number of tab
        let marginPercent = self.getStartPointPercented();//value that was defined by product team
        let screenWidth = bounds.width
        let tabWidthPercent = (1 - marginPercent * 2) / ( tabCount - 1) //percent of 1 tab
        let margin = ((1 - tabWidthPercent * tabCount) / 2) * screenWidth
        return margin;
    }
    
    func getStartPointPercented() -> CGFloat {
        switch (arrayTabs.count) {
        case 1:
            return 0.5
        case 2:
            return 0.3
        case 3:
            return 0.25
        case 4:
            return 0.125
        case 5:
            return 0.10
        default:
            return 0
        }
    }
    
    func scrollDidScroll(contentOffsetX: CGFloat) {
        let width = StringHelper.getTextWidth(text: arrayTabs[self.selectingTab], height: CellHeight, font: tabLabel.font) + IndicatorOffset * 2
        let originalX = self.getCellPostX(index: self.selectingTab)
        
        let screenSize: CGRect = UIScreen.main.bounds
        var offsetX = (contentOffsetX - screenSize.width) / CGFloat(arrayTabs.count)
        if offsetX > width {
            offsetX = width
        }else if offsetX < (width * (-1)) {
            offsetX = (width * (-1))
        }
        let cellWith = ceil((bounds.width - marginLeft * 2) / CGFloat(arrayTabs.count))
        //indicatorView.frame = CGRect(x: originalX + offsetX, y: bounds.height - BottomPadding, width: cellWith, height: 3)
        indicatorView.frame = CGRect(x: originalX + offsetX, y: 0, width: cellWith, height: bounds.height)
        print("indicatorLayer.frame  ", indicatorView.frame )
        //        CGRectMake(originalX + offsetX , bounds.height - BottomPadding, width , 1)
    }
    
    func setSelectedTab(tabIndex: Int){
        self.selectingTab = tabIndex
        self.refreshUI()
    }
}
