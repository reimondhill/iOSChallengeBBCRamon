//
//  BaseViewController.swift
//  RamonBBCChallengeiOS
//
//  Created by Ramon Haro Marques on 18/06/2019.
//  Copyright © 2019 Reimond Hill. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    //MARK:- Properties
    //MARK: Constants
    let networkHelper:NetworkHelper
    
    //MARK: Vars
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    
    //MARK:- Constructor
    init(networkHelper:NetworkHelper = NetworkHelper.shared) {
        
        self.networkHelper = networkHelper
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


//MARK:- Lifecycle methods
extension BaseViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.mainViewBackground
        view.accessibilityIdentifier = identifier
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        AnalyticsHelper.sendScreenAnalyticsEvent(identifier: identifier, network: networkHelper.network, completion: nil)
        
    }
    
    
}
