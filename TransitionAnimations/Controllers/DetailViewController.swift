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
            tableView.clipsToBounds = false
        }
    }

    
    private var detailDataSource = DetailDataSource()
    private var cardDetailHeight = CGFloat.zero
    private var cardView: CardView?
    
    private lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        button.tintColor = .white
        button.setTitle("X", for: .normal)
        button.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var shouldHideViews: Bool = false {
        didSet {
            tableView.isHidden = shouldHideViews
            dismissButton.isHidden = shouldHideViews
        }
    }
    
    override var prefersStatusBarHidden: Bool { return true }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        dismissButton.frame = CGRect(x: view.bounds.maxX - 60, y: 40, width: 40, height: 40)
        dismissButton.layer.cornerRadius = dismissButton.frame.height / 2
        
        view.addSubview(dismissButton)
        view.bringSubviewToFront(dismissButton)
    }
    
    @objc private func dismissButtonTapped() {
        let cell = tableView.dequeueReusableCell(withIdentifier: CardDetailCell.identifier, for: IndexPath(item: 0, section: 0)) as? CardDetailCell
        cardView = cell?.cardView
        self.dismiss(animated: true, completion: nil)
    }
    
    func setCardDetail(model: Model.Card, height: CGFloat) {
        detailDataSource.listModel = model
        cardDetailHeight = height
    }
    
    func getCardViewFrame() -> CGRect? {
        guard let cardView = cardView else { return nil }
        
        let newYOrigin = cardView.frame.origin.y + UIApplication.shared.statusBarFrame.height

        return CGRect(origin: .init(x: cardView.frame.origin.x, y: newYOrigin), size: cardView.frame.size)
    }
}

// MARK: UITableViewDelegate
extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? cardDetailHeight : UITableView.automaticDimension
    }
}
