//
//  CreateGameQuestOverviewCollectionViewDropDelegate.swift
//  GeoCaching
//
//  Created by Marcel Hagmann on 25.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

protocol CreateGameQuestOverviewCollectionViewDataChangedDelegate {
    func didMovedQuest(sourceIndexPath: IndexPath, destinationIndexPath: IndexPath)
}

class CreateGameQuestOverviewCollectionViewDropDelegate: NSObject, UICollectionViewDropDelegate {
    
    var delegate: CreateGameQuestOverviewCollectionViewDataChangedDelegate?
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        let destinationIndexPath: IndexPath
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            // get last index of collection view
            let section = collectionView.numberOfSections - 1
            let row = collectionView.numberOfItems(inSection: section)
            destinationIndexPath = IndexPath(row: row, section: section)
        }
        
        if coordinator.proposal.operation == .move {
            let items = coordinator.items
            let item = items.first!
            let sourceIndexPath = items.first!.sourceIndexPath!
            var destIndexPath = destinationIndexPath
            if destIndexPath.row >= collectionView.numberOfItems(inSection: 0) {
                destIndexPath.row = collectionView.numberOfItems(inSection: 0) - 1
            }
            
            let dSource = collectionView.dataSource as! CreateGameQuestOverviewCollectionViewDataSource
            item.dragItem.itemProvider.loadObject(ofClass: ItemProviderQuest.self) { (quest, error) in
                if let quest = quest as? ItemProviderQuest {
                    
                    DispatchQueue.main.async {
                        collectionView.performBatchUpdates( {
                            dSource.quests.remove(at: sourceIndexPath.row)
                            dSource.quests.insert(quest.quest, at: destIndexPath.row)
                            collectionView.deleteItems(at: [sourceIndexPath])
                            collectionView.insertItems(at: [destIndexPath])
                            
                            self.delegate?.didMovedQuest(sourceIndexPath: sourceIndexPath,
                                                         destinationIndexPath: destIndexPath)
                        })
                    }
                    
                }
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        if session.localDragSession != nil {
            if collectionView.hasActiveDrag {
                return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
            }
        }
        
        return UICollectionViewDropProposal(operation: .forbidden)
    }
}
