//
//  RemoteFeedLoader.swift
//  Feed
//
//  Created by Omran Khoja on 3/30/21.
//

import Foundation

class RemoteFeedLoader {
    
    var client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func load() {
        client.get(from: URL(string: "https://a-url.com")!)
    }
}
