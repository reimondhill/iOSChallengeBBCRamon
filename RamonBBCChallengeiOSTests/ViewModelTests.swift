//
//  ViewModelTests.swift
//  RamonBBCChallengeiOSTests
//
//  Created by Ramon Haro Marques on 19/06/2019.
//  Copyright © 2019 Reimond Hill. All rights reserved.
//

import Foundation
import XCTest

@testable import RamonBBCChallengeiOS

class ViewModelTests: XCTestCase {
    
    func testHeadlineCollectionViewCellViewModel(){
        
        let headline = Headline(headline: "A test will be performed!",
                                firstPublished: nil,
                                updated: nil,
                                introduction: "It is always good practice to test your code for ensuring great success!")
        
        let headlineCollectionViewCellVM = HeadlineCollectionViewCellViewModel(headline: headline)
        
        XCTAssertEqual(headlineCollectionViewCellVM.headlineTitle, headline.headline)
        XCTAssert(headlineCollectionViewCellVM.lastUpdated != "messages.unavailable")
        XCTAssertEqual(headlineCollectionViewCellVM.lastUpdated, NSLocalizedString("messages.unavailable", comment: ""))
        
    }
    
}

