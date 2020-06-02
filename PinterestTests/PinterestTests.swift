//
//  PinterestTests.swift
//  PinterestTests
//
//  Created by neelkant on 02/06/20.
//  Copyright © 2020 appscrip. All rights reserved.
//

import XCTest
@testable import Pinterest

class PinterestTests: XCTestCase {
    var pinterest: PinterestViewModel!
    var pinterestCollectionViewController: PinterestCollectionViewController!
    override func setUp()  {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        pinterest = PinterestViewModel()
        pinterestCollectionViewController = PinterestCollectionViewController(collectionViewLayout: PinterestLayout())
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        pinterest = nil
        pinterestCollectionViewController = nil
        super.tearDown()
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testReloadDataHandler()  {
        
        pinterestCollectionViewController.viewDidLoad()
      let reloadClousre =  pinterestCollectionViewController.pinterestViewModel.reloadData
        
//        XCTAssertGreaterThan(pinterestCollectionViewController.pinterestViewModel.listCount, 0, "listcount is zero")
       XCTAssert( pinterestCollectionViewController.collectionView.collectionViewLayout.isKind(of: PinterestLayout.self))
       XCTAssertNotNil(reloadClousre)
      
    }
      func testResponse() {
        

        // 1. Define an expectation
        let promise   = expectation(description: "SomeService does stuff and runs the callback closure")
 
        // 2. Exercise the asynchronous code
        pinterest.getImageList  { err in
            XCTAssertNil(err)
  
         promise.fulfill()
           
        }
  wait(for: [promise], timeout: 5)
      }
  
 
}
