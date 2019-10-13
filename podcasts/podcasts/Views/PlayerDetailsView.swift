//
//  PlayerDetailsView.swift
//  podcasts
//
//  Created by Rakesh Kumar on 13/10/19.
//  Copyright © 2019 Rakesh Kumar. All rights reserved.
//

import UIKit
import AVKit

class PlayerDetailsView: UIView {
    
    var episode: Episode? {
        didSet {
            if let episode = episode {
                titleLabel.text = episode.title
                authorLabel.text = episode.author
                playEpisode()
                guard let url = URL(string: episode.imageUrl ?? "") else { return }
                episodeImageView.sd_setImage(with: url)
            }
        }
    }
    
    private let player: AVPlayer = {
        let avPlayer = AVPlayer()
        avPlayer.automaticallyWaitsToMinimizeStalling = false
        return avPlayer
    }()
    
    @IBAction private func handleDismiss(_ sender: Any) {
        self.removeFromSuperview()
    }
    
    @IBOutlet private weak var episodeImageView: UIImageView!
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    @IBOutlet private weak var authorLabel: UILabel!
    
    @IBOutlet weak var playPauseButton: UIButton! {
        didSet {
            playPauseButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
            playPauseButton.addTarget(self, action: #selector(handlePlayPause), for: .touchUpInside)
        }
    }
    
    @objc private func handlePlayPause() {
        if player.timeControlStatus == .paused {
            player.play()
            playPauseButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        } else {
            player.pause()
            playPauseButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        }
    }
    
    private func playEpisode() {
        guard let episode = episode, let url = URL(string: episode.streamUrl) else {
            return
        }
        
        print("Trying to play episode at url:", episode.streamUrl)
        
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
    }
}
