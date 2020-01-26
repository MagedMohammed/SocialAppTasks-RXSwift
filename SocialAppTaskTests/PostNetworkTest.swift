//
//  PostNetworkTest.swift
//  SocialAppTaskTests
//
//  Created by Youxel mac5 on 1/23/20.
//  Copyright © 2020 Maged Mohammed. All rights reserved.
//

import XCTest
@testable import SocialAppTask

class PostNetworkTest: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testMockPostPresenter(){
        let mockPostPresenter = MockPostPresenter()
        mockPostPresenter?.getPostsData()
    }
    
    func testFetchPost(){
        let exp = self.expectation(description: "server fetch")
        var post = [Posts]()
        PostsRequest.getPosts { (data:[Posts]?, error) in
            if let data = data {
                post = data
                exp.fulfill()
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(post, "Post shuld not be nil ")
        print(post)
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        self.measure {
            let exp = self.expectation(description: "server fetch")
                PostsRequest.getPosts { (data:[Posts]?, error) in
                        exp.fulfill()
                }
                waitForExpectations(timeout: 5, handler: nil)
        }
    }
}
