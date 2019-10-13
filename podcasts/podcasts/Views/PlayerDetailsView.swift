//
//  PlayerDetailsView.swift
//  podcasts
//
//  Created by Rakesh Kumar on 13/10/19.
//  Copyright © 2019 Rakesh Kumar. All rights reserved.
//

import UIKit

class PlayerDetailsView: UIView {
    
    var episode: Episode? {
        didSet {
            if let episode = episode {
                titleLabel.text = episode.title
                authorLabel.text = episode.author
                guard let url = URL(string: episode.imageUrl ?? "") else { return }
                episodeImageView.sd_setImage(with: url)
            }
        }
    }
    
    @IBAction func handleDismiss(_ sender: Any) {
        self.removeFromSuperview()
    }
    
    @IBOutlet weak var episodeImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBAction func playPauseButton(_ sender: Any) {
    }
}
