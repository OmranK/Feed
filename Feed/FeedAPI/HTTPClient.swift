//
//  HTTPClient.swift
//  Feed
//
//  Created by Omran Khoja on 3/30/21.
//

import Foundation

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (Error) -> Void)
}
