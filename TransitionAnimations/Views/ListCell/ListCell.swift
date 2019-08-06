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
    @IBOutlet weak var containerView: UIView!
    
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
        didSet {
            titleView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        }
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
        titleView.layer.mask = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let shadowColor = shadowColor {
            // Apply shadow
            containerView.layer.shadowColor = shadowColor.cgColor
            containerView.layer.backgroundColor = UIColor.clear.cgColor
            containerView.layer.shadowOffset = CGSize(width: 0, height: 3.0)
            containerView.layer.shadowRadius = 12.0
            containerView.layer.shadowOpacity = 1.0
            containerView.layer.masksToBounds = false
            containerView.layer.shouldRasterize = true
            containerView.layer.rasterizationScale = UIScreen.main.scale
            
            // Apply rounded corners
            bgImageView.layer.cornerRadius = Defaults.radius
            bgImageView.layer.masksToBounds = true
            
            // Apply bottom rounded corners
            let maskPath = UIBezierPath(roundedRect: titleView.bounds,
                                        byRoundingCorners: UIRectCorner.init(arrayLiteral: .bottomLeft, .bottomRight),
                                        cornerRadii: .init(width: Defaults.radius, height: Defaults.radius))
            
            let maskLayer = CAShapeLayer()
            maskLayer.frame = titleView.bounds
            maskLayer.path  = maskPath.cgPath
            titleView.layer.mask = maskLayer
        }
    }

    
    // MARK: - Public Functions
    func configure(title: String, subTitle: String, image: UIImage, color: UIColor?) {
        titleLabel.text = title
        subtitleLabel.text = subTitle
        bgImageView.image = image
        
        if let color = color { shadowColor = color }
        
        setNeedsLayout()
        layoutIfNeeded()
    }
}

private extension ListCell {
    struct Defaults {
        static let radius: CGFloat = 12.0
        static let titleShadowKey = "titleShadowKey"
    }
}
