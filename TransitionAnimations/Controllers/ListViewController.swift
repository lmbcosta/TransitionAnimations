//
//  ListViewController.swift
//  TransitionAnimations
//
//  Created by Luis  Costa on 05/08/2019.
//  Copyright © 2019 Luis  Costa. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    private lazy var listDataSource = ListDataSource()
    
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
}
