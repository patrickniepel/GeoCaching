//
//  CardCollectionViewDelegate.swift
//  GeoCaching
//
//  Created by Philipp on 09.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

class CardCollectionViewDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{

    weak var vc : UIViewController!
    fileprivate let sectionInsets = UIEdgeInsets(top: 0, left: 16.0, bottom: 16.0, right: 16.0)
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.frame.height < 800 {
            let availableWidth = collectionView.frame.width - (sectionInsets.left + sectionInsets.right)
            return CGSize(width: availableWidth, height: availableWidth*0.4)
        }
        let availableWidth = collectionView.frame.width/2 - (sectionInsets.right+sectionInsets.left)
        return CGSize(width: availableWidth, height: availableWidth*0.4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dSource = collectionView.dataSource as! CardCollectionViewDataSource
        let selectedGame = dSource.getGame(atIndexPath: indexPath)
        vc.performSegue(withIdentifier: SearchIdentifiers.segue2GameDetail.identifier, sender: selectedGame)
    }
}
