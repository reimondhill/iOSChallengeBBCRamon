//
//  ExtensionsTests.swift
//  RamonBBCChallengeiOSTests
//
//  Created by Ramon Haro Marques on 19/06/2019.
//  Copyright © 2019 Reimond Hill. All rights reserved.
//

import XCTest
@testable import RamonBBCChallengeiOS

class MockClass:NSObject{
}


class ExtensionsTests: XCTestCase {
    
    //MARK:- DateExtension
    func testGetTimeComponentString(){
        
        let futureTimeStamps = [1,2,60,120,3600,7200,86400,172800,604800,1209600,2692000,5370400, 32536000, 64072000]
        //Date from 1st January 2019
        let currenDate = Date(timeIntervalSince1970: 1546300800)
        
        for futureTimeStamp in futureTimeStamps{
            
            let otherDate = currenDate.addingTimeInterval(TimeInterval(futureTimeStamp))
            guard futureTimeStamp > 0 else{ continue }
            guard let differenceString = Date.getTimeComponentString(olderDate: currenDate, newerDate: otherDate) else {
                XCTFail()
                return
            }
            //Seconds
            if futureTimeStamp < 60{
                XCTAssertEqual(differenceString, futureTimeStamp == 1 ? "1 second":"\(futureTimeStamp) seconds")
            }
            //Minutes
            if futureTimeStamp >= 60 && futureTimeStamp < 3600{
                XCTAssertEqual(differenceString, futureTimeStamp == 60 ? "1 minute":"\(futureTimeStamp/60) minutes")
            }
            //Hours
            if futureTimeStamp >= 3600 && futureTimeStamp < 86400{
                XCTAssertEqual(differenceString, futureTimeStamp == 3600 ? "1 hour":"\(futureTimeStamp / 3600) hours")
            }
            //Days
            if futureTimeStamp >= 86400 && futureTimeStamp < 604800{
                XCTAssertEqual(differenceString, futureTimeStamp == 86400 ? "1 day":"\(futureTimeStamp / 86400) days")
            }
            //Weeks
            if futureTimeStamp >= 604800 && futureTimeStamp < 2592000{
                XCTAssertEqual(differenceString, futureTimeStamp == 604800 ? "1 week":"\(futureTimeStamp / 604800) weeks")
            }
            //Months
            if futureTimeStamp >= 2592000 && futureTimeStamp < 31536000{
                let months = futureTimeStamp / 2592000
                XCTAssertEqual(differenceString, months == 1 ? "1 month":"\(months) months")
            }
            //Years
            if futureTimeStamp >= 31536000{
                let years = futureTimeStamp / 31536000
                XCTAssertEqual(differenceString, years == 1 ? "1 year":"\(years) years")
            }
        }
        
    }
    
    
    //MARK:- NSObjectExtension
    func testNSObjectLogClassName(){
        
        let mockClass = MockClass()
        XCTAssertEqual(mockClass.logClassName,"MockClass:")
        XCTAssertEqual(MockClass.logClassName,"MockClass:")
        
    }
    
    func testNSObjectIdentifier(){
        
        let mockClass = MockClass()
        XCTAssertEqual(mockClass.identifier, "MockClass")
        XCTAssertEqual(MockClass.identifier, "MockClass")
        
    }
    
    
    //MARK:- StringExtension
    func testStringCapitaliseFirstLetter(){
        
        let testString = "test".capitalizingFirstLetter()
        XCTAssert(testString == "Test")
        
    }
    
    func testStringCamelCaseToWords(){
        
        let camelCase = "camelCase".camelCaseToWords()
        XCTAssertEqual(camelCase,"camel Case")
        
    }
    
    
    //MARK:- UIEdgeInsetsExtension
    func testUIEdgeInsetsInit(){
        
        let inset = UIEdgeInsets(padding: 12)
        
        XCTAssertEqual(inset.top, 12)
        XCTAssertEqual(inset.top, inset.left)
        XCTAssertEqual(inset.top, inset.bottom)
        XCTAssertEqual(inset.top, inset.right)
    }
    
    
    //MARK:- UIImageExtension
    func testUIImageAspectRatio(){
        
        var image = UIImage(named: "bbc_logo_white_transparent")!
        XCTAssert(image.aspectRatioValue == image.size.width/image.size.height)
        
        image = UIImage()
        XCTAssert(image.aspectRatioValue == 0)
        
    }
    
    
    //MARK:- UIViewControllerExtension
    func testUIViewControllerCurrentTraitStatus(){
        
        let viewController = UIViewController()
        
        switch (UIScreen.main.traitCollection.horizontalSizeClass, UIScreen.main.traitCollection.verticalSizeClass){
            
        case (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular):
            return XCTAssertEqual(viewController.currentTraitStatus, .wRhR)
        case (UIUserInterfaceSizeClass.compact, UIUserInterfaceSizeClass.regular):
            return XCTAssertEqual(viewController.currentTraitStatus, .wChR)
        case (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.compact):
            return XCTAssertEqual(viewController.currentTraitStatus, .wRhC)
        case (UIUserInterfaceSizeClass.compact, UIUserInterfaceSizeClass.compact):
            return XCTAssertEqual(viewController.currentTraitStatus, .wChC)
            
        default:
            break
        }
        
    }
    
    
    //MARK:- UIViewExtension
    func testUIViewConstraintToSuperViewEdges(){
        
        let containerView = UIView(frame: CGRect(origin: .zero, size: .init(width: 50, height: 50)))
        
        let innerView = UIView()
        containerView.addSubview(innerView)
        let anchoredConstraints = innerView.constraintToSuperViewEdges()
        
        XCTAssert(innerView.translatesAutoresizingMaskIntoConstraints == false)
        XCTAssert(anchoredConstraints != nil)
        XCTAssert(anchoredConstraints?.top != nil && anchoredConstraints?.trailing != nil && anchoredConstraints?.bottom != nil && anchoredConstraints?.leading != nil)
        
    }
    
    func testUIViewAnchor(){
        
        let containerView = UIView(frame: CGRect(origin: .zero, size: .init(width: 50, height: 50)))
        
        let innerView = UIView()
        containerView.addSubview(innerView)
        let anchoredConstraints = innerView.anchor(top: containerView.topAnchor,
                                                   leading: containerView.leadingAnchor,
                                                   bottom: containerView.bottomAnchor,
                                                   trailing: containerView.trailingAnchor,
                                                   size: .init(width: 0, height: 0))
        
        XCTAssert(innerView.translatesAutoresizingMaskIntoConstraints == false)
        XCTAssert(anchoredConstraints.top != nil && anchoredConstraints.trailing != nil && anchoredConstraints.bottom != nil && anchoredConstraints.leading != nil)
        XCTAssert(anchoredConstraints.width == nil && anchoredConstraints.height == nil)
        
        
    }
    
    func testCenterInSuperview(){
        
        let containerView = UIView(frame: CGRect(origin: .zero, size: .init(width: 50, height: 50)))
        
        let innerView = UIView()
        containerView.addSubview(innerView)
        let anchoredConstraints = innerView.centerInSuperview(size: .init(width: 25, height: 25))
        
        XCTAssert(innerView.translatesAutoresizingMaskIntoConstraints == false)
        XCTAssert(anchoredConstraints.top == nil && anchoredConstraints.trailing == nil && anchoredConstraints.bottom == nil && anchoredConstraints.leading == nil)
        XCTAssert(anchoredConstraints.width != nil && anchoredConstraints.height != nil)
        XCTAssert(anchoredConstraints.centerX != nil && anchoredConstraints.centerY != nil)
        
        
    }
    
    func testUIViewBorders(){
        
        let directions:[Direction] = [.up, .left, .down, .right]
        let view = UIView(frame: CGRect(origin: .zero, size: .init(width: 50, height: 50)))
        let color = UIColor.red
        let size:CGFloat = 1
        
        for direction in directions{
            var borderView:UIView = UIView()
            
            switch direction{
            case .up:
                borderView = view.addTopSeparator(color: color, height: size, margins: 0)
            case .left:
                borderView = view.addLeftSeparator(color: color, width: size, margins: 0)
            case .down:
                borderView = view.addBottomSeparator(color: color, height: size, margins: 0)
            case .right:
                borderView = view.addRightSeparator(color: color, width: size, margins: 0)
            default:
                return
                
            }
            
            XCTAssertEqual(borderView.backgroundColor, color)
            XCTAssertEqual(borderView.superview, view)
            
        }
        
    }
    
    func testUIViewParentViewController(){
        
        let viewController = UIViewController()
        let aView = UIView()
        viewController.view.addSubview(aView)
        
        XCTAssert(aView.viewControler != nil)
        XCTAssertEqual(aView.viewControler, viewController)
        
        XCTAssert(aView.findViewController() != nil)
        XCTAssertEqual(aView.findViewController(), viewController)
        
    }
    
}
