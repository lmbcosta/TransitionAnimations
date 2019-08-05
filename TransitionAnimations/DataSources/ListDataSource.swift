//
//  ListDataSource.swift
//  TransitionAnimations
//
//  Created by Luis  Costa on 05/08/2019.
//  Copyright © 2019 Luis  Costa. All rights reserved.
//

import UIKit

class ListDataSource: NSObject, UICollectionViewDataSource {
    
    private lazy var titles = [
        "Happy Title",
        "Angry Title",
        "Sad Title",
        "Inlove Title"
    ]
    
    private lazy var subtitles = [
        "Some people can’t believe in themselves until someone else believes in them first.",
        "It’s only after we’ve lost everything that we’re free to do anything.",
        "It is not our abilities that show what we truly are… it is our choices.",
        "Every man dies, not every man really lives."
    ]
    
    private var models: [Model.List] = []
    
    override init() {
        super.init()
        
        titles.shuffle()
        subtitles.shuffle()
        images.shuffle()
        
        (0..<4).forEach({ models.append(Model.List(title: titles[$0], subtitle: subtitles[$0], image: images[$0])) })
    }
    
    private lazy var images = [
        UIImage(named: "Cenas") ?? UIImage(),
        UIImage(named: "Cenas") ?? UIImage(),
        UIImage(named: "Cenas") ?? UIImage(),
        UIImage(named: "Cenas") ?? UIImage()
    ]
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // TODO:
        return .init()
    }
}