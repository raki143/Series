//
//  EpisodesController.swift
//  podcasts
//
//  Created by Rakesh Kumar on 20/09/19.
//  Copyright © 2019 Rakesh Kumar. All rights reserved.
//

import UIKit

class EpisodesController: UITableViewController {
    
    var podcast: Podcast? {
        didSet{
           navigationItem.title = podcast?.trackName
        }
    }
    
    private let cellId = "cellId"
    
    var episodes = [
        Episode(title: "First Episode"),
        Episode(title: "Second Episode"),
        Episode(title: "Third Episode"),
        
        ]

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
}
