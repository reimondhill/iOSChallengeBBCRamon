//
//  HeadlineCollectionViewCell.swift
//  RamonBBCChallengeiOS
//
//  Created by Ramon Haro Marques on 18/06/2019.
//  Copyright © 2019 Reimond Hill. All rights reserved.
//

import UIKit

class HeadlineCollectionViewCell: UICollectionViewCell {
    
    //MARK:- Properties
    
    //MARK: Vars
    override var isSelected: Bool {
        didSet {
            
            let view = UIView(frame:self.bounds)
            view.backgroundColor = isSelected ? UIColor.selectionBackground : UIColor.primaryViewBackground
            self.selectedBackgroundView = view
            
        }
        
    }
    
    var headlineCellVM:HeadlineCollectionViewCellViewModel!{
        didSet{
            populateView(HeadlineCollectionViewCellViewModel: headlineCellVM)
        }
    }
    
    
    //UI
    lazy private(set) var titleLabel:BaseLabel = { BaseLabel(withConfiguration: .headline) }()
    lazy private (set) var lastUpdateLabel:BaseLabel = { BaseLabel(withConfiguration: .normalLight) }()
    
}


//MARK:- Lifecycle methods
extension HeadlineCollectionViewCell{
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        if superview != nil{
            
            setupView()
            
        }
        
    }
    
}


//MARK:- Private methods
private extension HeadlineCollectionViewCell{
    
    func setupView(){
        
        addBorder(borderWidth: Margins.xSmall, radius: BorderRadius.medium, color: .clear)
        backgroundColor = .primaryViewBackground
        
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor,
                          leading: leadingAnchor,
                          bottom: nil,
                          trailing: trailingAnchor,
                          padding: .init(padding: Margins.medium))
        
        addSubview(lastUpdateLabel)
        lastUpdateLabel.anchor(top: nil,
                               leading: leadingAnchor,
                               bottom: bottomAnchor,
                               trailing: trailingAnchor,
                               padding: .init(padding: Margins.medium))
        
        
    }
    
    func populateView(HeadlineCollectionViewCellViewModel:HeadlineCollectionViewCellViewModel){
        
        titleLabel.text = HeadlineCollectionViewCellViewModel.headlineTitle
        lastUpdateLabel.text = HeadlineCollectionViewCellViewModel.lastUpdated
        
    }
    
}
