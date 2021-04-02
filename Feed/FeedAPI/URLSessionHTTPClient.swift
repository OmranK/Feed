//
//  URLSessionHTTPClient.swift
//  Feed
//
//  Created by Omran Khoja on 4/2/21.
//

import Foundation

public final class URLSessionHTTPClient {
    private let session: URLSession
    
    public init (session: URLSession = .shared) {
        self.session = session
    }
    
    struct UnexpectedValuesRepresentation: Error {}
    
    public func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) {
        session.dataTask(with: url) { _, _, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.failure(UnexpectedValuesRepresentation()))
            }
        }.resume()
    }
    
}
