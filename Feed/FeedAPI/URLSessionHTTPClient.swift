//
//  URLSessionHTTPClient.swift
//  Feed
//
//  Created by Omran Khoja on 4/2/21.
//

import Foundation

public final class URLSessionHTTPClient {
    private let session: URLSession
    
    public init (session: URLSession) {
        self.session = session
    }
    
    public func get(from url: URL) {
        session.dataTask(with: url) { _, _, _ in }.resume()
    }
    
}
