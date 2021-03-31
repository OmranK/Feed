//
//  RemoteFeedLoader.swift
//  Feed
//
//  Created by Omran Khoja on 3/30/21.
//

import Foundation

public final class RemoteFeedLoader {
    
    private let client: HTTPClient
    private let url: URL
    
    public init(url: URL, client: HTTPClient) {
        self.client = client
        self.url = url
    }
    
    public func load() {
        client.get(from: url)
    }
}
