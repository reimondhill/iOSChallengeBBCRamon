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
        //app.launchArguments = ["TEST"]
        app.launch()
        
    }

    override func tearDown() {}

    func testHeadlinesViewController() {
        print("Hello from UITest after setup")

        let headlineCollectionView = app/*@START_MENU_TOKEN@*/.collectionViews["HeadlinesCollectionView"]/*[[".otherElements[\"HeadlinesViewController\"].collectionViews[\"HeadlinesCollectionView\"]",".collectionViews[\"HeadlinesCollectionView\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let headlineMessage = app/*@START_MENU_TOKEN@*/.staticTexts["HeadlinesMessageLabel"]/*[[".otherElements[\"HeadlinesViewController\"]",".staticTexts[\"No headlines available...\"]",".staticTexts[\"HeadlinesMessageLabel\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/

        print("Waiting for headlineCollectionView")
        _ = headlineCollectionView.waitForExistence(timeout: 2)
        //print("Waiting for headlineMessage")
        _ = headlineMessage.waitForExistence(timeout: 2)

        print("End Waiting")
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
        }

    }
    
}
