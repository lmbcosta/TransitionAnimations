//
//  ListViewController.swift
//  TransitionAnimations
//
//  Created by Luis  Costa on 05/08/2019.
//  Copyright © 2019 Luis  Costa. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    private var listDataSource = ListDataSource()
    
    // UI
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(UINib(nibName: ListCell.identifier, bundle: nil), forCellWithReuseIdentifier: ListCell.identifier)
            collectionView.dataSource = listDataSource
            collectionView.delegate = self
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            collectionView.collectionViewLayout = layout
            collectionView.bounces = false
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.isPagingEnabled = true
        }
    }
    
    func getSelectedCardView() -> CardView? {
        guard let indexPath = collectionView.indexPathsForSelectedItems?.first else { return nil }
        guard let cell = collectionView.cellForItem(at: indexPath) as? ListCell else { return nil }
        
        return cell.cardView
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: collectionView.bounds.width, height: self.view.bounds.height * 0.7)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Model
        let model = listDataSource.requestModel(for: indexPath.item)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailViewController = storyboard.instantiateViewController(withIdentifier: "detail-view-controller") as? DetailViewController else { return }
        detailViewController.setModel(model)
        
        present(detailViewController, animated: true, completion: nil)
    }
}
