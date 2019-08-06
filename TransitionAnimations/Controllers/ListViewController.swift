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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("Card with index \(indexPath.item) was selected")
        
        // Get Cell's containerView
        guard let cell = collectionView.cellForItem(at: indexPath) as? ListCell else { return }
        guard let containerSuperView = cell.containerView.superview else { return }
        
        // Model
        let model = listDataSource.requestModel(for: indexPath.item)
    }
}
