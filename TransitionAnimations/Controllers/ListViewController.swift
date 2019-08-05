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
            // TODO:
           // collectionView.dataSource = listDataSource
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        navigationController?.isNavigationBarHidden = true
    }
}
