//
//  RamonBBCChallengeiOSUITests.swift
//  RamonBBCChallengeiOSUITests
//
//  Created by Ramon Haro Marques on 18/06/2019.
//  Copyright © 2019 Reimond Hill. All rights reserved.
//

import XCTest

class RamonBBCChallengeiOSUITests: XCTestCase {

    var app: XCUIApplication!
    override func setUp() {
        super.setUp()
        
        print("Hello from setup")
        continueAfterFailure = true

        app = XCUIApplication()
        //Uncomment next line to use MOCKNetwork for the app
        app.launchArguments = ["TEST"]
        app.launch()
        
    }

    override func tearDown() {}

    //Simple UITest for HeadlinesViewController(
    func testHeadlinesViewController() {
        print("Hello from UITest after setup")

        let headlineCollectionView = app.collectionViews["HeadlinesCollectionView"]
        let headlineMessage = app.staticTexts["HeadlinesMessageLabel"]

        _ = headlineCollectionView.waitForExistence(timeout: 2)
        //print("Waiting for headlineMessage")
        _ = headlineMessage.waitForExistence(timeout: 2)

        if headlineCollectionView.cells.count == 0{
            print("CollectionView NO results")
            XCTAssert(headlineCollectionView.exists)
            XCTAssert(headlineMessage.isHittable)
        }
        else{
            print("CollectionView results = ", headlineCollectionView.cells.count)
            XCTAssert(headlineCollectionView.exists)
            if headlineMessage.exists{
                XCTAssert(headlineMessage.label == "")
            }
            
            
            let firstCell = headlineCollectionView.cells.firstMatch
            let labelsInHeadlinesCollectionCell = firstCell.children(matching: .staticText)
            
            let titleLabel = labelsInHeadlinesCollectionCell["HeadlineCollectionViewCellTitle"]
            XCTAssertEqual(titleLabel.label, "How to say: Diplodocus")
            
            let lastUpdateLabel = labelsInHeadlinesCollectionCell["HeadlineCollectionViewCellLastUpdated"]
            XCTAssertEqual(lastUpdateLabel.label, "5 months")
            
            firstCell.tap()
            
        }

    }
    
}
