//
//  HeadlineCollectionViewCellViewModel.swift
//  RamonBBCChallengeiOS
//
//  Created by Ramon Haro Marques on 18/06/2019.
//  Copyright © 2019 Reimond Hill. All rights reserved.
//

import UIKit

class HeadlineCollectionViewCellViewModel: NSObject {

    let headline:Headline
    
    var headlineTitle:String{
        return headline.headline ?? ""
    }
    var lastUpdated:String{
        return headline.lastUpdatedString() ?? NSLocalizedString("messages.unavailable", comment: "")
    }
    
    
    init(headline:Headline) {
        
        self.headline = headline
        super.init()
    
    }
    
}
