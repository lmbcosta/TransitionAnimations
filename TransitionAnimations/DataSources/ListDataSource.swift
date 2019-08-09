//
//  ListDataSource.swift
//  TransitionAnimations
//
//  Created by Luis  Costa on 05/08/2019.
//  Copyright © 2019 Luis  Costa. All rights reserved.
//

import UIKit

class ListDataSource: NSObject {
    private lazy var titles = [
        "Happy Title",
        "Angry Title",
        "Sad Title",
        "In love Title...In love Title...In love Title...In love Title...In love Title...In love Title...In love Title...In love Title...In love Title...In love Title...In love Title...In love Title...In love Title...In love Title...In love Title...In love Title...In love Title...In love Title...In love Title...In love Title...In love Title...In love Title...In love Title"
    ]
    
    private lazy var subtitles = [
        "Some people can’t believe in themselves until someone else believes in them first. Some people can’t believe in themselves until someone else believes in them first.",
        "It’s only after we’ve lost everything that we’re free to do anything.",
        "It is not our abilities that show what we truly are… it is our choices.",
        "Every man dies, not every man really lives."
    ]
    
    private var models: [Model.Card] = []
    
    override init() {
        super.init()
        
        titles.shuffle()
        subtitles.shuffle()
        images.shuffle()
        
        (0..<4).forEach({ models.append(Model.Card(title: titles[$0], subtitle: subtitles[$0], image: images[$0], color: images[$0].averageColor)) })
    }
    
    private lazy var images: [UIImage] = {
        var array = [UIImage]()
        (1...4).forEach({ array.append(UIImage.init(named: "landscapes-" + "\($0)") ?? UIImage()) })
        return array
    }()
    
    func requestModel(for index: Int) -> Model.Card {
        return models[index]
    }
}

// MARK: - UICollectionViewDataSource
extension ListDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = models[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCell.identifier, for: indexPath) as! ListCell
        cell.configure(title: model.title, subTitle: model.subtitle, image: model.image, color: model.color, mode: .card)
        
        cell.clipsToBounds = false
        cell.contentView.clipsToBounds = false
        cell.cardView?.clipsToBounds = false
        
        cell.layer.masksToBounds = false
        cell.contentView.layer.masksToBounds = false
        cell.cardView?.layer.masksToBounds = false
        
        return cell
    }
}
