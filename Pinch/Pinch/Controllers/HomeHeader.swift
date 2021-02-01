//
//  HomeHeader.swift
//  Pinch
//
//  Created by Josef Sajonz on 1/10/21.
//  Copyright © 2021 Josef Sajonz. All rights reserved.
//

import UIKit
import ScrollCounter

protocol HomeHeaderDelegate {
    func didTapAddItemButton()
}

class HomeHeader: UICollectionViewCell {
    
    var numberCounter: NumberScrollCounter!
    
    var delegate: HomeHeaderDelegate?
    
    // Use only as a get-only property
    var totalSaved: Float {
        return numberCounter.currentValue
    }
    
    private lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setImage(#imageLiteral(resourceName: "Image").withRenderingMode(.alwaysOriginal), for: .normal)
        button.layer.masksToBounds = true
        button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleTappedAddItemButton), for: .touchUpInside)
        
        return button
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "Saved"
        label.font = UIFont.systemFont(ofSize: 30)
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingHead
        return label
    }()
    
    static var headerId = "headerId"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    private func sharedInit() {
        
        addSubview(label)
        label.frame = CGRect(x: 20, y: 40, width: label.intrinsicContentSize.width, height: label.intrinsicContentSize.height)
        
        let font = UIFont.systemFont(ofSize: 30)
        
        numberCounter = NumberScrollCounter(value: 1, scrollDuration: 0.33, decimalPlaces: 2, prefix: "$", suffix: "", font: font, textColor: .black, gradientColor: .none, gradientStop: 0.2)
        
        addSubview(numberCounter)
        
        numberCounter.frame = CGRect(x: 20, y: label.bottom + 10, width: numberCounter.width, height: numberCounter.height)
        
        addSubview(addButton)
        
        addButton.frame = CGRect(x: width - 50, y: height - 40, width: 30, height: 30)
        
    }
    
    func updateTotalSaved(float: Float) { // Call this when you want to update the number in the middle
        numberCounter.setValue(float)
        
    }
    
    func incrementTotalSaved(by float: Float) {
        updateTotalSaved(float: totalSaved + float)
    }
    
    @objc private func handleTappedAddItemButton() {
        delegate?.didTapAddItemButton()
    }
    
    
}
