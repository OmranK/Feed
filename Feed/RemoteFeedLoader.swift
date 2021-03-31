//
//  RemoteFeedLoader.swift
//  Feed
//
//  Created by Omran Khoja on 3/30/21.
//

import Foundation

class HTTPClient {
    private init() {}
    static let shared = HTTPClient()
    var requestedURL: URL?
}

class RemoteFeedLoader {
    func load() {
        HTTPClient.shared.requestedURL = URL(string: "https://a-url.com")
    }
}
