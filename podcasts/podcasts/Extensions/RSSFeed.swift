//
//  RSSFeed.swift
//  podcasts
//
//  Created by Rakesh Kumar on 12/10/19.
//  Copyright © 2019 Rakesh Kumar. All rights reserved.
//

import Foundation
import FeedKit

extension RSSFeed {
    func toEpisodes() -> [Episode] {
        var episodes = [Episode]()
        let feedImageUrl = iTunes?.iTunesImage?.attributes?.href
        
        items?.forEach({ (feedItem) in
            var episode = Episode(feedItem: feedItem)
            
            if episode.imageUrl == nil {
                episode.imageUrl = feedImageUrl
            }
            episodes.append(episode)
        })
        return episodes
    }
}
