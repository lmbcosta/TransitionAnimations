//
//  DetailCell.swift
//  TransitionAnimations
//
//  Created by Luis  Costa on 07/08/2019.
//  Copyright © 2019 Luis  Costa. All rights reserved.
//

import UIKit

class DetailCell: UITableViewCell {
    static let identifier = "DetailCell"
    
    // UI
    @IBOutlet weak private var titleLabel: UILabel! {
        didSet {
            titleLabel.tintColor = .black
            titleLabel.textAlignment = .left
            titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .black)
            titleLabel.numberOfLines = 0
        }
    }
    
    @IBOutlet weak private var subtitleLabel: UILabel! {
        didSet {
            subtitleLabel.tintColor = .darkGray
            subtitleLabel.textAlignment = .left
            subtitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            subtitleLabel.numberOfLines = 0
        }
    }
    
    @IBOutlet weak private var separatorView: UIView! {
        didSet { separatorView.backgroundColor = .lightGray }
    }

    func configure(title: String, subtitle: String, isLastOne: Bool = false) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        
        separatorView.backgroundColor = isLastOne ? .white : .lightGray
    }
}
