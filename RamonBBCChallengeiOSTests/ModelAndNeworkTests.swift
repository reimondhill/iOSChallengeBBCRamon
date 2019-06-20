//
//  ModelAndNeworkTests.swift
//  RamonBBCChallengeiOSTests
//
//  Created by Ramon Haro Marques on 19/06/2019.
//  Copyright © 2019 Reimond Hill. All rights reserved.
//

import Foundation
import XCTest

@testable import RamonBBCChallengeiOS


class ModelAndNeworkTests: XCTestCase {

    func testGetHeadlinesResponse(){
        
        let networkHelper = NetworkHelper(network: MockNetwork())
        networkHelper.getHeadlines { [unowned self] (result) in
            
            switch result{
            case .success(let headlines):
                
                if let headline = headlines.sorted(by: {$0.updated ?? 0 > $1.updated ?? 0} ).first,
                     let lasUpdatedtString = headline.lastUpdatedString(from: Date(timeIntervalSince1970: 1560963600)) {
                    
                   XCTAssertEqual(lasUpdatedtString, "5 months")
                    
                }
                else{
                    XCTFail("\(self.logClassName) No Data available to test")
                }
                
            case .failure(let error):
                XCTFail("\(self.logClassName) testGetHeadlinesResponse ERROR -> \(error.localizedDescription)")
            }
            
        }
        
    }
    
    func testSendLoadAnalyticsStats(){
        
        let expectedString = "RamonBBCChallengeiOS.app/analytics?event=load&value=10"
        AnalyticsHelper.sendLoadAnalyticsEvent(time: 100, network: MockNetwork()) { (result) in

            switch result{

            case .success(let data):
                let dataString = String(decoding: data, as: UTF8.self)
                XCTAssert(dataString.contains(expectedString), "\(dataString) not contains \(expectedString)")

            case .failure(let error):
                XCTFail("testSendAnalyticsStats failed: \(error)")

            }

        }
        
    }
    
    func testSendScreenAnalyticsStats(){

        let expectedString = "RamonBBCChallengeiOS.app/analytics?event=display&value=HeadlinesViewController"
        AnalyticsHelper.sendScreenAnalyticsEvent(identifier: HeadlinesViewController.identifier, network: MockNetwork()) { (result) in

            switch result{

            case .success(let data):
                let dataString = String(decoding: data, as: UTF8.self)
                XCTAssert(dataString.contains(expectedString), "Bad request")

            case .failure(let error):
                XCTFail("testSendAnalyticsStats failed: \(error)")

            }

        }
    
    }
    
}
