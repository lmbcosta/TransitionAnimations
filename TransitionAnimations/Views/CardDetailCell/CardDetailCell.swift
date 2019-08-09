//
//  CardDetailCell.swift
//  TransitionAnimations
//
//  Created by Luis  Costa on 07/08/2019.
//  Copyright © 2019 Luis  Costa. All rights reserved.
//

import UIKit

class CardDetailCell: UITableViewCell {
    
    static let identifier = "CardDetailCell"
    
    lazy var cardView = CardView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        setCardView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setCardView() {
        addSubview(cardView)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        cardView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        cardView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        cardView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    func configure(title: String, subtitle: String, image: UIImage, color: UIColor?, mode: CardView.ViewMode) {
        cardView.setCard(title: title, subtitle: subtitle, image: image, color: color, mode: mode)
        layoutIfNeeded()
    }
}
