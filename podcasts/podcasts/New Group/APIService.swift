//
//  APIService.swift
//  podcasts
//
//  Created by Rakesh Kumar on 20/09/19.
//  Copyright © 2019 Rakesh Kumar. All rights reserved.
//

import Foundation
import Alamofire
import FeedKit

class APIService {
    
    static let shared = APIService()
    
    private let baseiTunesSearchURL = "https://itunes.apple.com/search"
    
    private init(){
    }
    
    func fetchEpisodes(feedUrl: String, completionHandler: @escaping ([Episode]?, PodcastErrors?) -> ()) {
        
        guard let url = URL(string: feedUrl) else {
            return
        }
        
        let parser = FeedParser(URL: url)
        parser.parseAsync { (result) in
            print("successfully parsed:",result.isSuccess)
            
            if let error = result.error {
                print("Failed to parse feed:", error)
                completionHandler(nil,PodcastErrors.failureToFetchEpisodes)
                return
            }
            
            guard let feed = result.rssFeed else {
                return
            }
            let episodes = feed.toEpisodes()
            completionHandler(episodes, nil)
        }
    }
    
    func fetchPodcasts(searchText: String, completionHandler: @escaping ([Podcast]?, PodcastErrors?) -> ()) {
        
        let parameters = ["term": searchText, "media": "podcast"]
        
        Alamofire.request(baseiTunesSearchURL, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseData { (dataResponse) in
            
            if let _ = dataResponse.error {
                completionHandler(nil,PodcastErrors.failureToFetchPodcasts)
                return
            }
            
            guard let data = dataResponse.data else { return }
            do {
                let searchResult = try JSONDecoder().decode(SearchResults.self, from: data)
                completionHandler(searchResult.results, nil)
            } catch let decodeErr {
                print("Failed to decode:", decodeErr)
            }
        }
    }
}
