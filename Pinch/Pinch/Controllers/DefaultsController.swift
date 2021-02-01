//
//  ViewController.swift
//  Pinch
//
//  Created by Josef Sajonz on 1/4/21.
//  Copyright © 2021 Josef Sajonz. All rights reserved.
//

import UIKit
import ScrollCounter

/// This class handles loading the user defaults data
class DefaultsController: UICollectionViewController, HomeHeaderDelegate {

    var defaults: UserDefaults!
    
    var items = [Item]()
    
    var header: HomeHeader? {
        didSet {
            if let header = header, let defaults = defaults {
                if let value = defaults.object(forKey: Global.totalSavedKey) as? Float {
                    header.updateTotalSaved(float: value)

                } else {
                    defaults.set(0, forKey: Global.totalSavedKey)
                    header.updateTotalSaved(float: 0)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaults = UserDefaults.standard
        
        retrieveItemsFromDefaults()
        
    }
    
    func retrieveItemsFromDefaults() {
        
        if let array = defaults.retrieve(object: [Item].self, fromKey: Global.itemsSavedKey) {
            self.items = array.sorted(by: { (item1, item2) -> Bool in
                return item1.creationDate > item2.creationDate
            })
        }
        
    }
    
    func addItem(item: Item) {
        
        items.append(item)
        
        items = items.sorted(by: { (item1, item2) -> Bool in
            return item1.creationDate > item2.creationDate
        })
        
        defaults.save(customObject: items, inKey: Global.itemsSavedKey)
 
    }
    
    func removeItem(index: Int) {
        
        items.remove(at: index)
        
        defaults.save(customObject: items, inKey: Global.itemsSavedKey)
        
    }
    
    func incrementTotalSaved(float: Float) {
        guard let header = header else { return }
        
        let updatedAmount = header.totalSaved + float
        
        defaults.set(updatedAmount, forKey: Global.totalSavedKey)
        header.updateTotalSaved(float: updatedAmount)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func updateTotalSaved(float: Float) {
        guard let header = header else { return }
        defaults.set(float, forKey: Global.totalSavedKey)
        header.updateTotalSaved(float: float)
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
    }
    
    func didTapAddItemButton() {
        let vc = AddItemController()
        
        DispatchQueue.main.async {
            self.present(vc, animated: true)
            
            vc.completion = { [weak self] item in
                guard let strongSelf = self else { return }
                
                strongSelf.addItem(item: item)
                
                strongSelf.incrementTotalSaved(float: item.price)
                
            }
            
            
        }
        
        
    }
    
    // MARK: - Testing

}

