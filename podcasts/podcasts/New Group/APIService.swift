//
//  APIService.swift
//  podcasts
//
//  Created by Rakesh Kumar on 20/09/19.
//  Copyright © 2019 Rakesh Kumar. All rights reserved.
//

import Foundation
import Alamofire

class APIService {
    
    static let shared = APIService()
    
    private let baseiTunesSearchURL = "https://itunes.apple.com/search"
    
    private init(){
    }
    
    func fetchPodcasts(searchText: String, completionHandler: @escaping ([Podcast]) -> ()) {
        
        let parameters = ["term": searchText, "media": "podcast"]
        
        Alamofire.request(baseiTunesSearchURL, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseData { (dataResponse) in
            
            if let err = dataResponse.error {
                print("Failed to fetch from itunes", err)
                return
            }
            
            guard let data = dataResponse.data else { return }
            do {
                let searchResult = try JSONDecoder().decode(SearchResults.self, from: data)
                completionHandler(searchResult.results)
            } catch let decodeErr {
                print("Failed to decode:", decodeErr)
            }
        }
    }
}
