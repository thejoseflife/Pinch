//
//  ItemCell.swift
//  Pinch
//
//  Created by Josef Sajonz on 1/4/21.
//  Copyright © 2021 Josef Sajonz. All rights reserved.
//

import UIKit

protocol ItemCellDelegate {
    func didSwipe(indexPath: Int, completion: @escaping () -> ())
}

class ItemCell: UICollectionViewCell, UIGestureRecognizerDelegate {
    
    static var cellId = "itemCellId"
    
    var delegate: ItemCellDelegate?
    var pan: UIPanGestureRecognizer!
    var deleteLabel: UILabel!
    
    var animating: Bool!
    
    var indexPathItem: Int?
    var item: Item? {
        didSet {
            
            titleLabel.text = item?.title
            titleLabel.frame = CGRect(x: 10, y: 0, width: width - 110, height: height)
            
            let string = String(format: "$%.2f", item!.price)
            
            valueLabel.text = string
            valueLabel.frame = CGRect(x: width - 110, y: height / 2 - 20, width: 100, height: 40)
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(name: Global.FONT, size: 17)
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
        
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(name: Global.FONT, size: 17)
        label.textColor = .white
        label.textAlignment = .center
        
        label.layer.backgroundColor = UIColor.rgb(red: 0, green: 220, blue: 10).cgColor
        //label.layer.backgroundColor = UIColor.rgb(red: 220, green: 0, blue: 0).cgColor
        label.layer.cornerRadius = 5
        
        return label
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    private func sharedInit() {
        backgroundColor = .systemBackground
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(valueLabel)
        
        let deleteBackground = UIView()
        deleteBackground.backgroundColor = .red
        deleteBackground.frame = CGRect(x: width, y: 0, width: width, height: height)
        contentView.addSubview(deleteBackground)
        
        deleteLabel = UILabel()
        contentView.addSubview(deleteLabel)
        deleteLabel.text = "delete"
        deleteLabel.textColor = UIColor.white
        deleteLabel.textAlignment = .center
        deleteLabel.backgroundColor = .red
        deleteLabel.frame = CGRect(x: width, y: 0, width: 100, height: height)
        
        animating = false
        

        pan = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        pan.delegate = self
        self.addGestureRecognizer(pan)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        if (pan.state == UIGestureRecognizer.State.changed) && !animating {
            let p: CGPoint = pan.translation(in: self)
            if p.x <= 0 {
                let width = self.contentView.frame.width
                let height = self.contentView.frame.height
                if p.x >= -deleteLabel.width {

                    self.contentView.frame = CGRect(x: p.x, y: 0, width: width, height: height);
                } else {
                    
                    self.contentView.frame = CGRect(x: -deleteLabel.width, y: 0, width: width, height: height);
                    
                    if pan.velocity(in: self).x < -200 {
                             
                        animating = true
                        
                        UIView.animate(withDuration: 0.3, animations: {
                            self.contentView.frame = CGRect(x: -self.width, y: 0, width: self.width, height: self.height)
                        }) { (result) in
                            
                            if let item = self.indexPathItem {
                                
                                self.delegate?.didSwipe(indexPath: item, completion: {
                                    
                                    self.setNeedsLayout()
                                    self.layoutIfNeeded()
                                    
                                    self.animating = false
                                    
                                    self.pan.isEnabled = false
                                    self.pan.isEnabled = true
                                    
                                })
                                
                            }

                        }


                    }
                    
                }

            }
        }

      }

    @objc func onPan(_ pan: UIPanGestureRecognizer) {
        
        if !animating {
            if pan.state == UIGestureRecognizer.State.began {
                
            } else if pan.state == UIGestureRecognizer.State.changed {
                
                self.setNeedsLayout()
            } else {
                UIView.animate(withDuration: 0.2, animations: {
                    self.setNeedsLayout()
                    self.layoutIfNeeded()
                })
            }
        }
        

    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return abs((pan.velocity(in: pan.view)).x) > abs((pan.velocity(in: pan.view)).y)
    }
}
    

