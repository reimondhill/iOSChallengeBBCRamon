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
        
        rtView.axis = .vertical
        rtView.spacing = Margins.large
        rtView.distribution = .fill
        
        return rtView
    }()
    
    
    //MARK:- Constructor
    init(networkHelper:NetworkHelper = NetworkHelper.shared, headline:Headline) {
        
        self.headline = headline
        super.init(networkHelper: networkHelper)
        
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
        populateContentStackView(headline: headline)
        
    }
    
}


//MARK:- Private methods
private extension HeadlineDetailsViewController{
    
    func setupView(){
        
        view.addSubview(scrollView)
        scrollView.constraintToSuperViewEdges(padding: .init(padding: Margins.medium), safeView: true)
        
        scrollView.addSubview(contentStackView)
        contentStackView.anchor(top: scrollView.topAnchor,
                                leading: scrollView.leadingAnchor,
                                bottom: scrollView.bottomAnchor,
                                trailing: scrollView.trailingAnchor,
                                width: scrollView.widthAnchor)
        
        
        
    }
    
    func populateContentStackView(headline:Headline){
        
        //Adding Headline + Last Updated
        let headerStackView = UIStackView()
        headerStackView.axis = .vertical
        headerStackView.spacing = 0
        headerStackView.distribution = .fill
        
        let headlineLabel = BaseLabel(withConfiguration: .headline)
        headlineLabel.text = headline.headline
        headerStackView.addArrangedSubview(headlineLabel)
        
        let lastUpdatedLabel = BaseLabel(withConfiguration: .normalLight)
        lastUpdatedLabel.text = headline.lastUpdatedString
        headerStackView.addArrangedSubview(lastUpdatedLabel)
        
        contentStackView.addArrangedSubview(headerStackView)
        
        //Adding introduction
        let introductionLabel = BaseLabel(withConfiguration: .normal)
        introductionLabel.text = headline.introduction
        contentStackView.addArrangedSubview(introductionLabel)

    }
    
}
