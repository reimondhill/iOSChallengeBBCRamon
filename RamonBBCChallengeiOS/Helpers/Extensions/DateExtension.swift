//
//  DateExtension.swift
//  RamonBBCChallengeiOS
//
//  Created by Ramon Haro Marques on 18/06/2019.
//  Copyright © 2019 Reimond Hill. All rights reserved.
//

import Foundation


extension Date{
    
    static func getTimeComponentString(olderDate older: Date,newerDate newer: Date) -> (String?)  {
        
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        
        let componentsLeftTime = Calendar.current.dateComponents([.second, .minute , .hour , .day, .month, .weekOfMonth, .year], from: older, to: newer)
        
        if let year = componentsLeftTime.year, year > 0 {
            formatter.allowedUnits = [.year]
        }
        else if let month = componentsLeftTime.month, month > 0 {
            formatter.allowedUnits = [.month]
        }
        else if let weekOfMonth = componentsLeftTime.weekOfMonth, weekOfMonth > 0 {
            formatter.allowedUnits = [.weekOfMonth]
        }
        else if let day = componentsLeftTime.day, day > 0 {
            formatter.allowedUnits = [.day]
        }
        else if let hour = componentsLeftTime.hour, hour > 0 {
            formatter.allowedUnits = [.hour]
        }
        else if let minute = componentsLeftTime.minute, minute > 0 {
            formatter.allowedUnits = [.minute]
        }
        else if let second = componentsLeftTime.second, second > 0 {
            formatter.allowedUnits = [.second]
        }
        else{
            formatter.allowedUnits = []
        }
        
        return formatter.string(from: older, to: newer)

    }
    
}
