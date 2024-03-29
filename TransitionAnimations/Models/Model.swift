//
//  Model.swift
//  TransitionAnimations
//
//  Created by Luis  Costa on 05/08/2019.
//  Copyright © 2019 Luis  Costa. All rights reserved.
//

import UIKit

enum Model {
    struct Card {
        let title: String
        let subtitle: String
        let image: UIImage
        let color: UIColor?
    }
    
    struct Detail {
        let title: String
        let subtitle: String
    }
}
