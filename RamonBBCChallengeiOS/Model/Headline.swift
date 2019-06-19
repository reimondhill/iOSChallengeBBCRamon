//
//  Headline.swift
//  RamonBBCChallengeiOS
//
//  Created by Ramon Haro Marques on 18/06/2019.
//  Copyright © 2019 Reimond Hill. All rights reserved.
//

import Foundation


struct Headline:Codable{
    
    let headline:String?
    let firstPublished:Int?
    let updated:Int?
    let introduction:String?
    
    //It can be done here
    var lastUpdatedString:String?{
        
        guard let updated = updated else{ return nil }
        return Date.getTimeComponentString(olderDate: Date.init(timeIntervalSince1970: Double(updated)),
                                           newerDate: Date())
        
    }
    
    enum CodingKeys: String, CodingKey {
        case headline
        case firstPublished = "first-published"
        case updated
        case introduction
    }
    
}
