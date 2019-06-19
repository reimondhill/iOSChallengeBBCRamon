//
//  Constants.swift
//  RamonBBCChallengeiOS
//
//  Created by Ramon Haro Marques on 18/06/2019.
//  Copyright © 2019 Reimond Hill. All rights reserved.
//


import UIKit

///Returns the default path value for the FourSquareDevData JSON file
let fourSquareConfigPath = "FourSquareDevData"

let unknown = NSLocalizedString("messages.unknown", comment: "")

///Custom Error structure
struct AppError:Error{
    
    private let message:String
    var localizedDescription: String { return message }
    
    init(_ message:String) {
        self.message = message
    }
    
}

/// Manages valid UITraitCollection configurations.
enum DeviceTraitStatus:CaseIterable {
    
    ///Width=Regular Height=Regular
    case wRhR
    ///Width=Compact Height=Regular
    case wChR
    ///Width=Regular Height=Compact
    case wRhC
    ///Width=Compact Height=Compact
    case wChC
    
    ///Calculates the current UITraitCollection. If Unknown, the default value is Width=Compact Height=Regular
    static var current:DeviceTraitStatus{
        
        switch (UIScreen.main.traitCollection.horizontalSizeClass, UIScreen.main.traitCollection.verticalSizeClass){
            
        case (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular):
            return .wRhR
        case (UIUserInterfaceSizeClass.compact, UIUserInterfaceSizeClass.regular):
            return .wChR
        case (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.compact):
            return .wRhC
        case (UIUserInterfaceSizeClass.compact, UIUserInterfaceSizeClass.compact):
            return .wChC
        default:
            return .wChR
            
        }
        
    }
    
}

/// Handles the posible device orientations
enum OrientationStatus:CaseIterable {
    
    /// Device is either landscapeLeft or landscapeRight
    case landscape
    /// Device is either portrait or portraitUpsideDown
    case portrait
    
    static var current:OrientationStatus{
        switch UIApplication.shared.statusBarOrientation{
        case .portrait:
            return .portrait
        case .portraitUpsideDown:
            return .portrait
        case .landscapeLeft:
            return .landscape
        case .landscapeRight:
            return .landscape
        default:
            return .portrait
        }
    }
    
}

///Defines posible directions of an object
enum Direction:CaseIterable {
    case up
    case upRight
    case right
    case downRight
    case down
    case downLeft
    case left
    case upLeft
}
