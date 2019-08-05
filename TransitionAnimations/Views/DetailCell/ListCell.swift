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
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            titleLabel.numberOfLines = 0
            titleLabel.textAlignment = .left
            titleLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        }
    }
    
    @IBOutlet private weak var subtitleLabel: UILabel! {
        didSet {
            subtitleLabel.numberOfLines = 0
            subtitleLabel.textAlignment = .left
            subtitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        }
    }
    
    @IBOutlet private weak var titleView: UIView! {
        didSet { titleView.backgroundColor = .clear }
    }
    
    @IBOutlet private weak var bgImageView: UIImageView! {
        didSet { bgImageView.contentMode = .scaleAspectFill }
    }
    
    private var shadowColor: UIColor?
    
    // MARK: - Override Functions
    override func prepareForReuse() {
        super.prepareForReuse()
        
        shadowColor = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Add shadow on cell
        backgroundColor = .clear // very important
        layer.masksToBounds = false
        layer.shadowOpacity = 0.23
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 0, height: 0)
        if let shadowColor = shadowColor { layer.shadowColor = shadowColor.cgColor }
        
        // Add corner radius on ContentView
        contentView.layer.cornerRadius = 8
    }
    
    // MAK: - Public Functions
    func configure(title: String, subTitle: String, image: UIImage) {
        titleLabel.text = title
        subtitleLabel.text = subTitle
        bgImageView.image = image
        
        shadowColor = image.averageColor
        
        setNeedsLayout()
        layoutIfNeeded()
    }
}
