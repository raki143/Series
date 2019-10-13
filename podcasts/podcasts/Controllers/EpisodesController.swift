//
//  EpisodesController.swift
//  podcasts
//
//  Created by Rakesh Kumar on 20/09/19.
//  Copyright © 2019 Rakesh Kumar. All rights reserved.
//

import UIKit
import FeedKit

class EpisodesController: UITableViewController {
    
    var podcast: Podcast? {
        didSet{
           navigationItem.title = podcast?.trackName
            fetchEpisodes()
        }
    }
    
    private let cellId = "cellId"
    
    private var episodes = [Episode]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    //MARK:- Setup Work
    
    private func setupTableView() {
        let nib = UINib(nibName: "EpisodeCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
    }
    
    //MARK:- UITableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? EpisodeCell else {
            return UITableViewCell()
        }
        cell.episode = episodes[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 134
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = self.episodes[indexPath.row]
        print("Trying to play episode:", episode.title)
        
        let window = UIApplication.shared.keyWindow
        
        if let playerDetailsView = Bundle.main.loadNibNamed("PlayerDetailsView", owner: self, options: nil)?.first as? PlayerDetailsView {
            playerDetailsView.episode = episode
            playerDetailsView.frame = self.view.frame
            window?.addSubview(playerDetailsView)
        }
    }
    
    //MARK:- Networking Methods
    private func fetchEpisodes(){
        print("Looking for episodes at feed url:", podcast?.feedUrl ?? "")
        guard let feedUrl = podcast?.feedUrl?.toSecureHTTPS() else {
            return
        }
        
        APIService.shared.fetchEpisodes(feedUrl: feedUrl) { [weak self] (episodes, error) in
            
            guard let weakSelf = self else {
                return
            }
            
            guard error == nil else {
                return
            }
            
            guard let episodes = episodes else {
                return
            }
            
            weakSelf.episodes = episodes
            DispatchQueue.main.async {
                weakSelf.tableView.reloadData()
            }
            
        }
    }
}
