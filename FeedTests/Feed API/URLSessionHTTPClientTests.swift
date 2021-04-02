//
//  URLSessionHTTPClientTests.swift
//  FeedTests
//
//  Created by Omran Khoja on 4/2/21.
//

import XCTest
import Feed

class URLSessionHTTPClientTests: XCTestCase {
    
    func test_getFromURL_failsOnRequestError() {
        URLProtocolStub.startInterceptingRequest()
        let url = URL(string: "http://any-url.com")!
        let error = NSError(domain: "any error", code: 1)
        URLProtocolStub.stub(url: url, error: error)
        let sut = URLSessionHTTPClient()
        
        let exp = expectation(description: "Wait for completion")
        
        sut.get(from: url) { result in
            switch result {
            case let .failure(receivedError as NSError):
                XCTAssertEqual(receivedError.domain, error.domain)
            default:
                XCTFail("Expected failure with error \(error), got \(result) instead")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
        URLProtocolStub.stopInterceptingRequest()
    }
    
    
    
    // MARK: - Helpers
    
    private class URLProtocolStub: URLProtocol {
        
        private struct Stub {
            let error: Error?
        }
        
        private static var stubs = [URL: Stub]()
        
        static func stub(url: URL, error: Error? = nil) {
            stubs[url] = Stub(error: error)
        }
        
        static func startInterceptingRequest() {
            URLProtocol.registerClass(URLProtocolStub.self)
        }
        
        
        static func stopInterceptingRequest() {
            URLProtocol.unregisterClass(URLProtocolStub.self)
            stubs = [:]
        }
        
        // URLProtocol methods we need to implement to subclass it

        override class func canInit(with request: URLRequest) -> Bool {
            guard let url = request.url else { return false }
            return stubs[url] != nil
        }
        
        override class func canonicalRequest(for request: URLRequest) -> URLRequest {
            return request
        }
        
        override func startLoading() {
            guard let url = request.url, let stub = URLProtocolStub.stubs[url] else { return }
            
            if let error = stub.error {
                client?.urlProtocol(self, didFailWithError: error)
            }
            client?.urlProtocolDidFinishLoading(self)
            
        }
        
        override func stopLoading() { }
    }
}

