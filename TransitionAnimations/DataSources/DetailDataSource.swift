//
//  DetailDataSource.swift
//  TransitionAnimations
//
//  Created by Luis  Costa on 07/08/2019.
//  Copyright © 2019 Luis  Costa. All rights reserved.
//

import UIKit

class DetailDataSource: NSObject {
    
    var models = [Model.Detail]()
    var listModel: Model.List?
    
    override init() {
        super.init()
        
        let random = Int.random(in: 1...4)
        
        titles.shuffle()
        subtitles.shuffle()
        
        (0..<random).forEach { _ in
            let randomIndex = Int.random(in: 0..<4)
            models.append(Model.Detail(title: titles[randomIndex], subtitle: subtitles[randomIndex]))
        }
    }
    
    private lazy var titles = [
        "Weight of Love",
        "In Time",
        "TurnLovel",
        "Fever",
    ]
    
    private lazy var subtitles = [
        "The Black Keys is an American rock band formed in Akron, Ohio, in 2001",
        "The group consists of Dan Auerbach (guitar, vocals) and Patrick Carney (drums). The duo began as an independent act, recording music in basements and self-producing their records, before they eventually emerged as one of the most popular garage rock artists during a second wave of the genre's revival in the 2010s. The band's raw blues rock sound draws heavily from Auerbach's blues influences, including Junior Kimbrough, Howlin' Wolf, and Robert Johnson.",
        "Friends since childhood, Auerbach and Carney founded the group after dropping out of college. After signing with indie label Alive, they released their debut album, The Big Come Up (2002), which earned them a new deal with Fat Possum Records. Over the next decade, the Black Keys built an underground fanbase through extensive touring of small clubs, frequent album releases and music festival appearances, and broad licensing of their songs. Their third album, Rubber Factory (2004), received critical acclaim and boosted the band's profile, eventually leading to a record deal with major label Nonesuch Records in 2006. After self-producing and recording their first four records in makeshift studios, the duo completed Attack & Release (2008) in a professional studio and hired producer Danger Mouse, who subsequently became a frequent collaborator with the band.",
        "The group's commercial breakthrough came in 2010 with Brothers, which along with its popular single \"Tighten Up\", won three Grammy Awards. Their 2011 follow-up El Camino received strong reviews and peaked at number two on the Billboard 200 chart, leading to the first arena concert tour of the band's career, the El Camino Tour. The album and its hit single \"Lonely Boy\" won three Grammy Awards. In 2014, they released their eighth album, Turn Blue, their first number-one record in the US, Canada, and Australia. After completing the Turn Blue Tour in 2015, the duo took a hiatus for several years to work on side projects and produce other artists. They returned in 2019 with their ninth album, Let's Rock.",
    ]
    
    func requestModel(for index: Int) -> Model.Detail {
        return models[index]
    }
}

// MARK: - TableViewDataSource
extension DetailDataSource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CardDetailCell.identifier, for: indexPath) as! CardDetailCell
            
            if let model = self.listModel {
                cell.configure(title: model.title, subtitle: model.subtitle, image: model.image, color: model.color, mode: .extended)
            }
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailCell.identifier, for: indexPath) as! DetailCell
        let model = models[indexPath.item]
        let isLastOne = indexPath.item + 1 == models.count
        
        cell.configure(title: model.title, subtitle: model.subtitle, isLastOne: isLastOne)
        return cell
    }
}
