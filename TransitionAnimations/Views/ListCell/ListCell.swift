//
//  ListCell.swift
//  TransitionAnimations
//
//  Created by Luis  Costa on 05/08/2019.
//  Copyright © 2019 Luis  Costa. All rights reserved.
//

import UIKit

class ListCell: UICollectionViewCell {
    
    // UI
    @IBOutlet weak var cardView: CardView!
    
    // Properties
    static let identifier = "ListCell"
    
    // MARK: - Override Functions
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: - Public Functions
    func configure(title: String, subTitle: String, image: UIImage, color: UIColor?, mode: CardView.ViewMode) {
        cardView.setCard(title: title, subtitle: subTitle, image: image, color: color, mode: mode)
        
        layoutIfNeeded()
    }
}
