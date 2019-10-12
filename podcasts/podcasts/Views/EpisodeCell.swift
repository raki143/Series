//
//  EpisodeCell.swift
//  podcasts
//
//  Created by Rakesh Kumar on 12/10/19.
//  Copyright © 2019 Rakesh Kumar. All rights reserved.
//

import UIKit

class EpisodeCell: UITableViewCell {
    
    var episode: Episode? {
        didSet {
            if let episode = episode {
                titleLabel.text = episode.title
                descriptionLabel.text = episode.description
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMM dd,yyyy"
                dateLabel.text = dateFormatter.string(from: episode.pubDate)
            }
        }
    }
    
    @IBOutlet weak var episodeImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
}
