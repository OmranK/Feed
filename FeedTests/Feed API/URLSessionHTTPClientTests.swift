//
//  URLSessionHTTPClientTests.swift
//  FeedTests
//
//  Created by Omran Khoja on 4/2/21.
//

import XCTest
import Feed

class URLSessionHTTPClientTests: XCTestCase {
    
    func test_getFromURL_createsDataTaskWithURL() {
        let url = URL(string: "http://any-url.com")!
        let session = URLSessionSpy()
        let sut = URLSessionHTTPClient(session: session)
        sut.get(from: url)
        
        XCTAssertEqual(session.receivedURLs, [url])
    }
    
    func test_getFromURL_resumesDataTaskWithURL() {
        let url = URL(string: "http://any-url.com")!
        let session = URLSessionSpy()
        let task = URLSessionDataTaskSpy()
        session.stub(url: url, task: task)
        let sut = URLSessionHTTPClient(session: session)
        sut.get(from: url)
        
        XCTAssertEqual(task.resumeCallCount, 1)
    }
    
    
    
    // MARK: - Helpers
    
    private class URLSessionSpy: URLSession {
        override init() {}
        
        private var stubs = [URL: URLSessionDataTask]()
        
        var receivedURLs = [URL]()
        
        func stub(url: URL, task: URLSessionDataTask) {
            stubs[url] = task
        }
        
        override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            receivedURLs.append(url)
            return stubs[url] ?? FakeURLSessionDataTask()
        }
    }
    
    private class URLSessionDataTaskSpy: URLSessionDataTask {
        override init() {}
        
        var resumeCallCount = 0
        
        override func resume() {
            resumeCallCount += 1
        }
    }

    private class FakeURLSessionDataTask: URLSessionDataTask {
        override init() {}
        override func resume() {}
    }
}

