//
//  PodcastCell.swift
//  podcasts
//
//  Created by Rakesh Kumar on 20/09/19.
//  Copyright © 2019 Rakesh Kumar. All rights reserved.
//

import UIKit
import SDWebImage

class PodcastCell: UITableViewCell {
    
    @IBOutlet weak var podcastImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var episodeCountLabel: UILabel!
    
    override func prepareForReuse() {
        podcastImageView.image = nil
        trackNameLabel.text = nil
        episodeCountLabel.text = nil
        artistNameLabel.text = nil
    }
    
    var podcast: Podcast? {
        didSet{
            if let podcast = podcast{
                trackNameLabel.text = podcast.trackName
                artistNameLabel.text = podcast.artistName
                episodeCountLabel.text = "\(String(describing: podcast.trackCount ?? 0)) Episodes"
                
                guard let url = URL(string: podcast.artworkUrl600 ?? "") else {
                    return
                }
                podcastImageView.sd_setImage(with: url, completed: nil)
            }
        }
    }
}
