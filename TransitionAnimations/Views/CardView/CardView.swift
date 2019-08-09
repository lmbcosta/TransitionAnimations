//
//  CardView.swift
//  TransitionAnimations
//
//  Created by Luis  Costa on 06/08/2019.
//  Copyright © 2019 Luis  Costa. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    enum ViewMode {
        case card
        case extended
    }
    
    // UI
    @IBOutlet private var contentView: UIView!
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var containerView: UIView!
    
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
    
    // Constraints
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    // Properties
    private var shadowColor = UIColor.black
    private var mode: ViewMode = .card
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadFromNib()
    }
    
    // MARK: Private Functions
    private func loadFromNib() {
        Bundle.main.loadNibNamed("CardView", owner: self, options: nil)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
    }
    
    // MARK: Public Functions
    func setCard(title: String, subtitle: String, image: UIImage, color: UIColor?, mode: CardView.ViewMode) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        bgImageView.image = image
        if let color = color { shadowColor = color }
        
        self.mode = mode
        
        updateCornerRadius(for: mode)
        updateLayout(for: mode)
    }
    
    func updateLayout(for mode: ViewMode) {
        switch mode {
        case .card:
            leadingConstraint.constant = Defaults.constraintConstant
            topConstraint.constant = Defaults.constraintConstant
            trailingConstraint.constant = Defaults.constraintConstant
            bottomConstraint.constant = Defaults.constraintConstant
            showShadow(true)
        case .extended:
            leadingConstraint.constant = 0
            topConstraint.constant = 0
            trailingConstraint.constant = 0
            bottomConstraint.constant = 0
            showShadow(false)
        }
    }
    
    func updateCornerRadius(for mode: ViewMode) {
        switch mode {
        case .card:
            containerView.layer.cornerRadius = Defaults.radius
            containerView.layer.masksToBounds = true
        case .extended:
            containerView.layer.cornerRadius = 0
            containerView.layer.masksToBounds = true
        }
    }
}

// MARK: - Private Funtions
private extension CardView {
    func showShadow(_ value: Bool) {
        shadowView.layer.cornerRadius = value ? Defaults.radius : 0
        shadowView.layer.shadowColor = value ? shadowColor.cgColor : UIColor.clear.cgColor
        shadowView.layer.shadowOpacity = value ? 0.7 : 0
        shadowView.layer.shadowRadius = value ? Defaults.shadowRadius : 0
        shadowView.layer.shadowOffset = value ? .init(width: -1, height: 3) : .zero        
    }
}

private extension CardView {
    struct Defaults {
        static let radius: CGFloat = 16.0
        static let constraintConstant: CGFloat = 20
        static let shadowRadius: CGFloat = 10
    }
}


