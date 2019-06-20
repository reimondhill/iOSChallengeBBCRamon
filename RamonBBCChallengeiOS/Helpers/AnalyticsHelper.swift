//
//  AnalyticsHelper.swift
//  RamonBBCChallengeiOS
//
//  Created by Ramon Haro Marques on 19/06/2019.
//  Copyright © 2019 Reimond Hill. All rights reserved.
//

import UIKit

class AnalyticsHelper: NSObject {

    //MARK:- Properties
    //MARK: Constants
    ///Types of action
    enum Event:String, CaseIterable{
        case load
        case display
        /*More to come*/
    }
    
}


//MARK:- Public methods
extension AnalyticsHelper{
    
    static func sendLoadAnalyticsEvent(time:UInt64, network:Network, completion: ((Result<Data, Error>)->Void)?) {
        sendStat(for: .load, value: String(time), network: network, completion: completion)
    }
    
    static func sendScreenAnalyticsEvent(identifier: String, network:Network, completion: ((Result<Data, Error>)->Void)?) {
        sendStat(for: .display, value: identifier, network: network, completion: completion)
    }
    
    static func sendStat(for event:Event, value:String, network:Network, completion: ((Result<Data, Error>)->Void)?) {

        print(logClassName, "Sending stat")
        network.send(params: [event.rawValue:value],
                     urlString: network.analyticsURL,
                     requestType: .get,
                     completion: completion)

    }
    
}

