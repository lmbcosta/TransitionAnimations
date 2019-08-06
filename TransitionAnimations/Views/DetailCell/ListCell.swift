//
//  ListCell.swift
//  TransitionAnimations
//
//  Created by Luis  Costa on 05/08/2019.
//  Copyright © 2019 Luis  Costa. All rights reserved.
//

import UIKit

class ListCell: UICollectionViewCell {
    
    static let identifier = "ListCell"
    
    // UI
    @IBOutlet private weak var containerView: UIView!
    
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            titleLabel.numberOfLines = 0
            titleLabel.textAlignment = .left
            titleLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
            titleLabel.textColor = .white
        }
    }
    
    @IBOutlet private weak var subtitleLabel: UILabel! {
        didSet {
            subtitleLabel.numberOfLines = 0
            subtitleLabel.textAlignment = .left
            subtitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            subtitleLabel.textColor = .white
        }
    }
    
    @IBOutlet private weak var titleView: UIView! {
        didSet { titleView.backgroundColor = .clear }
    }
    
    @IBOutlet private weak var bgImageView: UIImageView! {
        didSet { bgImageView.contentMode = .scaleAspectFill
            bgImageView.backgroundColor = .clear
        }
    }
    
    private var shadowColor: UIColor?
    
    // MARK: - Override Functions
    override func prepareForReuse() {
        super.prepareForReuse()
        
        shadowColor = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let shadowColor = shadowColor {
            containerView.layer.shadowColor = shadowColor.cgColor
            containerView.layer.backgroundColor = UIColor.clear.cgColor
            containerView.layer.shadowOffset = CGSize(width: 0, height: -1.0)
            containerView.layer.shadowRadius = 12.0
            containerView.layer.shadowOpacity = 0.8
            containerView.layer.masksToBounds = false
            containerView.layer.shadowPath = UIBezierPath(roundedRect: containerView.layer.bounds, cornerRadius: 12.0).cgPath
            
            bgImageView.layer.cornerRadius = 12.0
            bgImageView.layer.masksToBounds = true
        }
    }

    
    // MAK: - Public Functions
    func configure(title: String, subTitle: String, image: UIImage, color: UIColor) {
        titleLabel.text = title
        subtitleLabel.text = subTitle
        bgImageView.image = image
        
        shadowColor = image.averageColor
        
        setNeedsLayout()
        layoutIfNeeded()
    }
}
