//
//  URLSessionHTTPClient.swift
//  Feed
//
//  Created by Omran Khoja on 4/2/21.
//

import Foundation

public protocol HTTPSession {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> HTTPSessionTask
}
public protocol HTTPSessionTask {
    func resume()
}

public final class URLSessionHTTPClient {
    private let session: HTTPSession
    
    public init (session: HTTPSession) {
        self.session = session
    }
    
    public func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) {
        session.dataTask(with: url) { _, _, error in
            if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
    
}
