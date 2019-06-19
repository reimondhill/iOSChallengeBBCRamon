//
//  HeadlinesViewController.swift
//  RamonBBCChallengeiOS
//
//  Created by Ramon Haro Marques on 18/06/2019.
//  Copyright © 2019 Reimond Hill. All rights reserved.
//

import UIKit

class HeadlinesViewController: BaseViewController {

    //MARK:- Properties
    //MARK: Constants
    let networkHelper:NetworkHelper
    
    
    //MARK: Vars
    var headlines:[Headline] = []
    
    //UI
    lazy private (set) var headlinesCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let rtView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return rtView
        
    }()
    
    
    
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
extension HeadlinesViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        updateHeadlines()
        
    }
    
}


//MARK:- Private methods
private extension HeadlinesViewController{
    
    func setupView(){
        
    }
    
    func updateHeadlines(){
        
        print("Getting the thing")
        networkHelper.getHeader { [weak self] (result) in
            
            print("END Getting the thing")
            switch result{
                
            case .success(let response):
                print("YEAAAAH")
            case .failure(_):
                print("PUTAAAAA")
            }
            
        }
        
    }
    
}
