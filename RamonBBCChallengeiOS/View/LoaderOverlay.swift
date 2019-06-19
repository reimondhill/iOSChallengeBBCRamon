//
//  LoaderOverlay.swift
//  RamonBBCChallengeiOS
//
//  Created by Ramon Haro Marques on 18/06/2019.
//  Copyright © 2019 Reimond Hill. All rights reserved.
//

import UIKit


class LoaderOverlay{

    //MARK:- Properties
    //MARK: Constants
    static let shared: LoaderOverlay = LoaderOverlay()
    
    
    //MARK: Vars
    var isPresented = false
    
    //UI
    var backgroundView = UIView()
    var overlayView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    
    
    //MARK:- Constructor
    //Only use the singleton by now
    private init(){}
    
}


//MARK:- Public methods
extension LoaderOverlay{
    
    func showOverlay(view: UIView = UIApplication.shared.keyWindow!) {
        
        guard !isPresented else{ return }
        
        isPresented = true
        backgroundView = UIView(frame: view.frame)
        backgroundView.backgroundColor = UIColor.popupViewBackground
        backgroundView.autoresizingMask = [.flexibleLeftMargin,
                                           .flexibleTopMargin,
                                           .flexibleRightMargin,
                                           .flexibleBottomMargin,.flexibleHeight, .flexibleWidth]
        
        overlayView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        overlayView.center = view.center
        overlayView.autoresizingMask = [.flexibleLeftMargin,.flexibleTopMargin,.flexibleRightMargin,.flexibleBottomMargin]
        overlayView.backgroundColor = UIColor.black
        overlayView.clipsToBounds = true
        overlayView.layer.cornerRadius = 10
        backgroundView.addSubview(overlayView)
        
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        activityIndicator.style = .whiteLarge
        activityIndicator.center = CGPoint(x: overlayView.bounds.width / 2, y: overlayView.bounds.height / 2)
        overlayView.addSubview(activityIndicator)
        
        view.addSubview(backgroundView)
        activityIndicator.startAnimating()
        
    }
    
    public func hideOverlayView() {
        
        activityIndicator.stopAnimating()
        backgroundView.removeFromSuperview()
        isPresented = false
        
    }
    
}


