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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
    }
    
    //MARK:- UITableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let episode = episodes[indexPath.row]
        cell.textLabel?.text = episode.title
        return cell
    }
    
    //MARK:- Networking Methods
    private func fetchEpisodes(){
        print("Looking for episodes at feed url:", podcast?.feedUrl ?? "")
        guard let feedUrl = podcast?.feedUrl else {
            return
        }
        
        let secureFeedUrl = feedUrl.contains("https") ? feedUrl : feedUrl.replacingOccurrences(of: "http", with: "https")
        
        guard let url = URL(string: secureFeedUrl) else {
            return
        }
        
        let parser = FeedParser(URL: url)
        parser.parseAsync { (result) in
            print("successfully parsed:",result.isSuccess)
            switch result {
            case let .rss(feed):
                feed.items?.forEach({ (feedItem) in
                    let episode = Episode(title: feedItem.title ?? "")
                    self.episodes.append(episode)
                })
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            case let .failure(error):
                print("Failed to parse feed:", error)
            default:
                break
            }
        }
    }
}
