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
    let loaderOverlay:LoaderOverlay
    
    private let refreshControl = UIRefreshControl()
    
    
    //MARK: Vars
    var headlines:[Headline] = []
    var numOfCells:CGFloat{
        switch currentTraitStatus {
        case .wRhR:
            return 3
        case .wChR:
            return 1
        case .wChC, .wRhC:
            return 2
        }
    }
    
    
    //UI
    lazy private (set) var headlinesCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let rtView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        rtView.backgroundColor = .clear
        rtView.register(HeadlineCollectionViewCell.self, forCellWithReuseIdentifier: HeadlineCollectionViewCell.identifier)
        rtView.dataSource = self
        rtView.delegate = self
        
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        rtView.alwaysBounceVertical = true
        rtView.refreshControl = refreshControl
        
        return rtView
        
    }()
    lazy private (set) var messageLabel:BaseLabel = {
        let rtView = BaseLabel(withConfiguration: .normal)

        rtView.textAlignment = .center
        
        return rtView
    }()
    
    
    
    //MARK:- Constructor
    init(networkHelper:NetworkHelper = NetworkHelper.shared, loaderOverlay:LoaderOverlay = LoaderOverlay.shared) {
        
        self.loaderOverlay = loaderOverlay
        super.init(networkHelper: networkHelper)
        
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
        updateHeadlines(showingLoader:true, completion: nil)
        title = NSLocalizedString("messages.topStories", comment: "")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        headlinesCollectionView.reloadData()
        
    }
    
}


//MARK:- Private methods
private extension HeadlinesViewController{
    
    func setupView(){
        
        view.addSubview(headlinesCollectionView)
        headlinesCollectionView.accessibilityIdentifier = "HeadlinesCollectionView"
        headlinesCollectionView.constraintToSuperViewEdges(padding: .init(padding: Margins.small), safeView: true)
        
        view.addSubview(messageLabel)
        messageLabel.accessibilityIdentifier = "HeadlinesMessageLabel"
        messageLabel.anchor(top: nil,
                            leading: view.leadingAnchor,
                            bottom: nil,
                            trailing: view.trailingAnchor,
                            padding: .init(padding: Margins.medium),
                            centerX: view.centerXAnchor,
                            centerY: view.centerYAnchor)
        
        
    }
    
    func updateHeadlines(showingLoader:Bool = false, completion: (()->Void)?){
        
        print(logClassName,"Getting headlines")
        
        if showingLoader{
            loaderOverlay.showOverlay()
        }
        networkHelper.getHeadlines { [weak self] (result) in
            
            guard let strongSelf = self else { return }
            
            DispatchQueue.main.async {
                
                print(strongSelf.logClassName,"Finished getting headlines")
                switch result{
                    
                case .success(let response):
                    print(strongSelf.logClassName,"Succes getting headlines")
                    strongSelf.headlines = response.sorted(by: { $0.updated ?? 0 > $1.updated ?? 0 })
                case .failure(let error):
                    print(strongSelf.logClassName,"Error getting headlines:", error)
                    strongSelf.headlines = []
                }
                
                strongSelf.messageLabel.text = strongSelf.headlines.count > 0 ? "":NSLocalizedString("messages.noHeadlines", comment: "")
                strongSelf.messageLabel.isHidden = strongSelf.headlines.count > 0
                strongSelf.headlinesCollectionView.reloadData()
                strongSelf.loaderOverlay.hideOverlayView()
                completion?()
                
            }
            
        }
        
    }
    
    @objc func didPullToRefresh(sender: Any) {
        print(logClassName, "Refreshing")
        
        updateHeadlines { [weak self] in
            
            guard let strongSelf = self else { return }
            strongSelf.refreshControl.endRefreshing()
            
        }
        
    }
    
}


//MARK:- UICollectionView methods
//MARK: UICollectionViewDataSource
extension HeadlinesViewController:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return headlines.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let headlineCell = collectionView.dequeueReusableCell(withReuseIdentifier: HeadlineCollectionViewCell.identifier, for: indexPath) as? HeadlineCollectionViewCell{
            
            headlineCell.headlineCellVM = HeadlineCollectionViewCellViewModel(headline: headlines[indexPath.row])
            
            return headlineCell
        }
        else{
            return UICollectionViewCell()
        }
        
    }
    
}

//MARK: UICollectionViewDelegateFlowLayout
extension HeadlinesViewController:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var width = ( (collectionView.bounds.width / numOfCells) - ( (2 * Margins.medium) / numOfCells ) )
        
        //extra padding
        if numOfCells > 1{
            width -= Margins.medium
        }
        
        let height = Margins.medium + 46 + Margins.large + 21 + Margins.medium
        
        return CGSize(width: width, height: height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(padding: Margins.medium)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return Margins.medium
        
    }
    
}

//MARK: UICollectionViewDelegate
extension HeadlinesViewController:UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(HeadlineDetailsViewController(networkHelper: networkHelper,
                                                                               headline: headlines[indexPath.row]),
                                                 animated: true)
    }
    
}
