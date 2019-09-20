//
//  PodcastsSearchController.swift
//  podcasts
//
//  Created by Rakesh Kumar on 12/09/19.
//  Copyright © 2019 Rakesh Kumar. All rights reserved.
//

import UIKit
import Alamofire


class PodcastsSearchController: UITableViewController {
    
    private var podcasts = [
        Podcast(trackName: "Lets Build That App", artistName: "Brian Voong"),
        Podcast(trackName: "Some Podcast", artistName: "Some Author")
        ]
    
    private let cellId = "cellId"
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchBar()
    }
    
    //MARK:- Setup work
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    //MARK:- UITableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let podcast = self.podcasts[indexPath.row]
        cell.textLabel?.text = "\(podcast.trackName ?? "")\n\(podcast.artistName ?? "")"
        cell.textLabel?.numberOfLines = -1
        cell.imageView?.image = UIImage(named: "appIcon")
        return cell
    }
    
}

extension PodcastsSearchController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        APIService.shared.fetchPodcasts(searchText: searchText) { [weak self] (podcasts) in
            self?.podcasts = podcasts
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}
