//
//  DetailViewController.swift
//  TransitionAnimations
//
//  Created by Luis  Costa on 05/08/2019.
//  Copyright © 2019 Luis  Costa. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.allowsSelection = false
            tableView.bounces = false
            tableView.register(UINib(nibName: DetailCell.identifier, bundle: nil), forCellReuseIdentifier: DetailCell.identifier)
            tableView.register(CardDetailCell.self, forCellReuseIdentifier: CardDetailCell.identifier)
            tableView.dataSource = detailDataSource
            tableView.delegate = self
            tableView.separatorStyle = .none
        }
    }
    
    private var detailDataSource = DetailDataSource()
    
    private lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        button.tintColor = .white
        button.setTitle("X", for: .normal)
        button.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setNeedsStatusBarAppearanceUpdate()
        
        dismissButton.frame = CGRect(x: view.bounds.maxX - 60, y: 40, width: 40, height: 40)
        dismissButton.layer.cornerRadius = dismissButton.frame.height / 2
        
        view.addSubview(dismissButton)
        view.bringSubviewToFront(dismissButton)
        
        
        
        
//        dismissButton.translatesAutoresizingMaskIntoConstraints = false
//        dismissButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        dismissButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
//        dismissButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40).isActive = true
//        dismissButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 40).isActive = true
    }
    
    
    
    func setModel(_ model: Model.List) {
        detailDataSource.listModel = model
    }
    
    @objc private func dismissButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: UITableViewDelegate
extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? view.bounds.height * 0.7 : UITableView.automaticDimension
    }
}
