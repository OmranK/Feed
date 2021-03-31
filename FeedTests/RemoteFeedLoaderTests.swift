//
//  RemoteFeedLoaderTests.swift
//  FeedTests
//
//  Created by Omran Khoja on 3/30/21.
//

import XCTest
@testable import Feed

class RemoteFeedLoaderTests: XCTestCase {
    
    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClient()
        _ = RemoteFeedLoader()
        XCTAssertNil(client.requestedURL)
    }
}

class HTTPClient {
    var requestedURL: URL?
}
