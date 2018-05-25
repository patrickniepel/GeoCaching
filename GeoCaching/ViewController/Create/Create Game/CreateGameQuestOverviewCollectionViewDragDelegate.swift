//
//  CreateGameQuestOverviewCollectionViewDragDelegate.swift
//  GeoCaching
//
//  Created by Marcel Hagmann on 25.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

class CreateGameQuestOverviewCollectionViewDragDelegate: NSObject, UICollectionViewDragDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        if let dragItem = createDragItem(forIndexPath: indexPath, inCollectionView: collectionView) {
            return [dragItem]
        }
        return []
    }
    
    func collectionView(_ collectionView: UICollectionView, itemsForAddingTo session: UIDragSession, at indexPath: IndexPath, point: CGPoint) -> [UIDragItem] {
        if let dragItem = createDragItem(forIndexPath: indexPath, inCollectionView: collectionView) {
            return [dragItem]
        }
        return []
    }
    
    private func createDragItem(forIndexPath indexPath: IndexPath, inCollectionView collectionView: UICollectionView) -> UIDragItem? {
        if let dSource = collectionView.dataSource as? CreateGameQuestOverviewCollectionViewDataSource {
            let quest = dSource.getQuest(atIndexPath: indexPath)
            let questClass = ItemProviderQuest(quest: quest)
            
            let itemProvider = NSItemProvider(object: questClass)
            let dragItem = UIDragItem(itemProvider: itemProvider)
            return dragItem
        }
        
        return nil
    }
}
