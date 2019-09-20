//
//  Podcast.swift
//  podcasts
//
//  Created by Rakesh Kumar on 12/09/19.
//  Copyright © 2019 Rakesh Kumar. All rights reserved.
//

import Foundation

struct Podcast: Decodable {
    var trackName: String?
    var artistName: String?
}

struct SearchResults: Decodable {
    let resultCount: Int
    let results: [Podcast]
}
