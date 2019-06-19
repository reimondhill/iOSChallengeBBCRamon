//
//  NetworkHelper.swift
//  RamonBBCChallengeiOS
//
//  Created by Ramon Haro Marques on 18/06/2019.
//  Copyright © 2019 Reimond Hill. All rights reserved.
//

import UIKit

import UIKit

class NetworkHelper: NSObject {
    
    //MARK:- Properties
    //MARK: Constants
    enum NetworkHelperError:Error{
        case invalidURL
        case noResponse
    }
    
    static let shared = NetworkHelper()
    let network:Network
    
    
    
    //MARK:- Constructor
    required init(network:Network = AppNetwork()){
        
        self.network = network
        super.init()
        
    }
    
}


//MARK:- Public methods
extension NetworkHelper{
    
    //ALL at the moment
    func getHeader(completion:@escaping (Result<HeadlineResponse, Error>)->Void){
        
        let urlComponents = URLComponents(string: network.headlinesEnhanced)
        //Fututre URL GET query items
        
        guard let headlinesURL = urlComponents?.url else{
            completion(.failure(NetworkHelper.NetworkHelperError.invalidURL))
            return
        }
        
        let hedlinesURLRequest = URLRequest(url: headlinesURL, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 5)
        
        network.fetchCodable(urlRequest: hedlinesURLRequest) { (_ headlineResult: Result<HeadlineResponse, Error>) in
        
            switch headlineResult{
            case .success(let headlineResponse):
                completion(.success(headlineResponse))
            case .failure(let resultError):
                completion(.failure(resultError))
            }
            
        }
        
    }

}
