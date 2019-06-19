//
//  BaseLabel.swift
//  RamonBBCChallengeiOS
//
//  Created by Ramon Haro Marques on 18/06/2019.
//  Copyright © 2019 Reimond Hill. All rights reserved.
//

import UIKit

class BaseLabel: UILabel {

    //MARK:- Properties
    //MARK: Constants
    enum LabelConfiguration:Int, CaseIterable{
        //Custom NavBars
        case navBar = 0
        case normal = 1
        case normalLight = 2
        case headline = 3
        //More future cases
    }
    
    
    //MARK: Vars
    var labelConfiguration:LabelConfiguration = .normal{
        didSet{
            setupView()
        }
    }
    @IBInspectable var labelConfigurationOption:Int{
        get{
            return labelConfiguration.rawValue
        }
        set{
            guard let labelConfiguration = LabelConfiguration(rawValue: newValue) else{ return }
            self.labelConfiguration = labelConfiguration
        }
    }
    
    
    
    //MARK:- Constructor
    init(withConfiguration labelConfiguration:LabelConfiguration) {
        
        self.labelConfiguration = labelConfiguration
        super.init(frame: .zero)
        setupView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        //Despite not using neither storyboards nor xib, it supports this constructor for possible future development
        super.init(coder: aDecoder)
        
    }
    
}


//MARK:- Private methods
extension BaseLabel{
    
    func setupView(){
        
        numberOfLines = 0
        textAlignment = .left
        
        switch labelConfiguration {
        case .navBar:
            textColor = UIColor.navigationBarText
            font = UIFont.systemFont(ofSize: TextSize.navigationTitle, weight: .semibold)
        //normal & normalLight could go together but it is easier to read and change by separating them
        case .normal:
            textColor = UIColor.mainText
            font = UIFont.systemFont(ofSize: TextSize.normal, weight: .regular)
            textAlignment = .justified
        case .normalLight:
            textColor = UIColor.secondaryText
            font = UIFont.systemFont(ofSize: TextSize.normal, weight: .light)
        case .headline:
            textColor = UIColor.mainText
            font = UIFont.systemFont(ofSize: TextSize.title, weight: .bold)
        }
        
    }
    
}
