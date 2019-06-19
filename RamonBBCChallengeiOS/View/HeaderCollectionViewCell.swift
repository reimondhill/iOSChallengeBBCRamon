//
//  HeaderCollectionViewCell.swift
//  RamonBBCChallengeiOS
//
//  Created by Ramon Haro Marques on 18/06/2019.
//  Copyright © 2019 Reimond Hill. All rights reserved.
//

import UIKit

class HeaderCollectionViewCell: UICollectionViewCell {
    
    //MARK:- Properties
    
    //MARK: Vars
    var headerCellVM:HeaderCollectionViewCellViewModel!{
        didSet{
            populateView(headerCollectionViewCellViewModel: headerCellVM)
        }
    }
    
    
    //UI
    lazy private(set) var titleLabel:BaseLabel = {
        let rtView = BaseLabel(withConfiguration: .headline)
        
        rtView.numberOfLines = 0
        rtView.textAlignment = .center
        
        return rtView
    }()
    lazy private (set) var lastUpdateLabel:BaseLabel = {
        let rtView = BaseLabel(withConfiguration: .normalLight)
        
        rtView.numberOfLines = 1
        rtView.textAlignment = .left
        
        return rtView
    }()
    
}


//MARK:- Lifecycle methods
extension HeaderCollectionViewCell{
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        if superview != nil{
            
            setupView()
            
        }
        
    }
    
}


//MARK:- Private methods
private extension HeaderCollectionViewCell{
    
    func setupView(){
        
        addBorder(borderWidth: Margins.xSmall, radius: BorderRadius.medium, color: UIColor.defaultSeparator)
        
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor,
                          leading: leadingAnchor,
                          bottom: nil,
                          trailing: trailingAnchor,
                          padding: .init(padding: Margins.medium))
        
        addSubview(lastUpdateLabel)
        lastUpdateLabel.anchor(top: titleLabel.bottomAnchor,
                               leading: titleLabel.leadingAnchor,
                               bottom: bottomAnchor,
                               trailing: titleLabel.trailingAnchor,
                               padding: .init(top: Margins.small, left: 0, bottom: 0, right: 0))
        
        
    }
    
    func populateView(headerCollectionViewCellViewModel:HeaderCollectionViewCellViewModel){
        
        titleLabel.text = headerCollectionViewCellViewModel.headlineTitle
        lastUpdateLabel.text = headerCollectionViewCellViewModel.lastUpdated
        
    }
    
}
