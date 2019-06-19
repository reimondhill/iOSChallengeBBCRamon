//
//  HeadlineDetailsViewController.swift
//  RamonBBCChallengeiOS
//
//  Created by Ramon Haro Marques on 18/06/2019.
//  Copyright © 2019 Reimond Hill. All rights reserved.
//

import UIKit

class HeadlineDetailsViewController: BaseViewController {

    
    //MARK:- Properties
    //MARK: Constants
    let headline:Headline
    
    
    //MARK: Vars
    lazy private (set) var scrollView:UIScrollView = { return UIScrollView() }()
    lazy private (set) var contentStackView:UIStackView = {
        let rtView = UIStackView()
        
        return rtView
    }()
    
    
    //MARK:- Constructor
    init(headline:Headline) {
        
        self.headline = headline
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


//MARK:- Lifecycle methods
extension HeadlineDetailsViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
    }
    
}


//MARK:- Private methods
private extension HeadlineDetailsViewController{
    
    func setupView(){
        
        view.addSubview(scrollView)
        scrollView.constraintToSuperViewEdges(padding: .init(padding: Margins.medium), safeView: true)
        
        
        
    }
    
}
