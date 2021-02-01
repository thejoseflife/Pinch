//
//  HomeController.swift
//  Pinch
//
//  Created by Josef Sajonz on 1/9/21.
//  Copyright © 2021 Josef Sajonz. All rights reserved.
//

import UIKit
import Foundation

/// This class is for the item collectionview and deals with the logic of adding them
class HomeController: DefaultsController, ItemCellDelegate {

    private var animating: Bool = false
    
    let navBar: VerticalAlignedLabel = {
        let bar = VerticalAlignedLabel()
        bar.contentMode = .bottom
        bar.backgroundColor = .systemBackground
        bar.textAlignment = .center
        bar.numberOfLines = 2
        bar.font = UIFont(name: Global.FONT, size: 20)
        bar.text = ""
        return bar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .systemBackground
        collectionView?.register(HomeHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeHeader.headerId)
        collectionView?.register(ItemCell.self, forCellWithReuseIdentifier: ItemCell.cellId)
        collectionView.showsVerticalScrollIndicator = false
        
        navBar.frame = CGRect(x: 0, y: 0, width: view.width, height: 50)
        
        view.addSubview(navBar)
        
        view.backgroundColor = .systemBackground
        
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let header = header {
            let realCenter = collectionView.convert(CGPoint(x: 0, y: header.top), to: collectionView.superview)
            
            if !animating {
                
                animating = true
                
                if realCenter.y < -100 {

                    UIView.transition(with: self.navBar, duration: 0.1, options: .transitionCrossDissolve, animations: {
                        
                        let string = String(format: "$%.2f", header.totalSaved)
                        
                        self.navBar.text = String(string)
                        
                    }) { (result) in
                        self.animating = false
                    }

                } else {
                    
                    UIView.transition(with: self.navBar, duration: 0.1, options: .transitionCrossDissolve, animations: {
                        
                        self.navBar.text = ""
                        
                    }) { (result) in
                        self.animating = false
                    }

                }
            }
            

        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if header == nil {
            header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeHeader.headerId, for: indexPath) as? HomeHeader
            header!.delegate = self
        }
        return header!
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.cellId, for: indexPath) as! ItemCell
        cell.item = items[indexPath.item]
        cell.delegate = self
        cell.indexPathItem = indexPath.item
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func didSwipe(indexPath: Int, completion: @escaping () -> ()) {
        removeItem(index: indexPath)

        DispatchQueue.main.async {
            self.collectionView.reloadData()
            
            completion()
        }
    }
    
}

extension HomeController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.width, height: 200)
    }
    
    
}
