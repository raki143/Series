//
//  String.swift
//  podcasts
//
//  Created by Rakesh Kumar on 12/10/19.
//  Copyright © 2019 Rakesh Kumar. All rights reserved.
//

import Foundation

extension String {
    func toSecureHTTPS() -> String {
        return self.contains("https") ? self : self.replacingOccurrences(of: "http", with: "https")
    }
}
