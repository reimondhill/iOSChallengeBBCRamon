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
        continueAfterFailure = false

        app = XCUIApplication()
        //Uncomment next line to use MOCKNetwork for the app
        app.launchArguments = ["TEST"]
        app.launch()
        
        print("Hello from setup")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        print("Hello from UITest after setup")

        let headlineCollectionView = app/*@START_MENU_TOKEN@*/.collectionViews["HeadlinesCollectionView"]/*[[".otherElements[\"HeadlinesViewController\"].collectionViews[\"HeadlinesCollectionView\"]",".collectionViews[\"HeadlinesCollectionView\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let headlineMessage = app/*@START_MENU_TOKEN@*/.staticTexts["HeadlinesMessageLabel"]/*[[".otherElements[\"HeadlinesViewController\"]",".staticTexts[\"No headlines available...\"]",".staticTexts[\"HeadlinesMessageLabel\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/

        print("Waiting for headlineCollectionView")
        //XCTAssert(headlineCollectionView.waitForExistence(timeout: 2))
        //print("Waiting for headlineMessage")
        //XCTAssert(headlineMessage.waitForExistence(timeout: 2))

        print("End Waiting")
        collectionLabelAssert(collection: headlineCollectionView, label: headlineMessage)
//
//        sleep(5)
//
//        collectionLabelAssert(collection: headlineCollectionView, label: headlineMessage)
    }

    func collectionLabelAssert(collection:XCUIElement, label:XCUIElement){

        if collection.cells.count == 0{
            print("CollectionView NO results")
            XCTAssert(collection.exists)
            XCTAssert(label.isHittable)
        }
        else{
            print("CollectionView results = ", collection.cells.count)
            XCTAssert(collection.exists)
            XCTAssert(!label.isHittable)
        }

    }

}
