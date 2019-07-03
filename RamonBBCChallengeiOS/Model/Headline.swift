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
    
    enum CodingKeys: String, CodingKey {
        case headline
        case firstPublished = "first-published"
        case updated
        case introduction
    }
    
    
    //It can be done here
    func lastUpdatedString(from date:Date = Date())->String?{
        
        guard let updated = updated else{ return nil }
        return Date.getTimeComponentString(olderDate: Date(timeIntervalSince1970: Double(updated)),
                                           newerDate: date)
        
    }

    func getDateString()->String?{

        guard let firstPublished = firstPublished,
            let updated = updated else{ return nil }

        /*
“Published: 1 January 1970, 11:29:11 | Updated: 2 January 1971, 09:14:56”.
         */

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy, HH:mm:ss"

        let publishDate = Date(timeIntervalSince1970: TimeInterval(firstPublished))
        let lastUpdatedDate = Date(timeIntervalSince1970: TimeInterval(updated))

        let publishDateString = String(format: NSLocalizedString("messages.publishedWithString", comment: ""), dateFormatter.string(from: publishDate))
        let updatedDateString = String(format: NSLocalizedString("messages.updatedWithString", comment: ""), dateFormatter.string(from: lastUpdatedDate))

        if firstPublished != updated{
            return "\(publishDateString) | \(updatedDateString)"

        }
        else{
            return publishDateString
        }

    }

}
