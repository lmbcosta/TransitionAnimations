//
//  CardView.swift
//  TransitionAnimations
//
//  Created by Luis  Costa on 06/08/2019.
//  Copyright © 2019 Luis  Costa. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    // UI
    @IBOutlet private var contentView: UIView!
    
    @IBOutlet weak var bgImageView: UIImageView! {
        didSet { bgImageView.contentMode = .scaleAspectFill }
    }
    
    @IBOutlet weak var titleView: UIView! {
        didSet {
             titleView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.numberOfLines = 0
            titleLabel.textAlignment = .left
            titleLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
            titleLabel.textColor = .white
        }
    }
    
    @IBOutlet weak var subtitleLabel: UILabel! {
        didSet {
            subtitleLabel.numberOfLines = 0
            subtitleLabel.textAlignment = .left
            subtitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            subtitleLabel.textColor = .white
        }
    }
    
    var shadowColor: UIColor?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let shadowColor = shadowColor {
            // Apply shadow
            contentView.layer.shadowColor = shadowColor.cgColor
            contentView.layer.backgroundColor = UIColor.clear.cgColor
            contentView.layer.shadowOffset = CGSize(width: 0, height: 3.0)
            contentView.layer.shadowRadius = 12.0
            contentView.layer.shadowOpacity = 1.0
            contentView.layer.masksToBounds = false
            contentView.layer.shouldRasterize = true
            contentView.layer.rasterizationScale = UIScreen.main.scale
            
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
    
    // MARK: Private Functions
    private func loadFromNib() {
        Bundle.main.loadNibNamed("CardView", owner: self, options: nil)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
    }
    
    // MARK: Public Functions
    func setCard(title: String, subtitle: String, image: UIImage, color: UIColor?) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        bgImageView.image = image
        
        if let color = color {
            shadowColor = color
        }
    }
}

private extension CardView {
    struct Defaults {
        static let radius: CGFloat = 12.0
        static let titleShadowKey = "titleShadowKey"
    }
}


