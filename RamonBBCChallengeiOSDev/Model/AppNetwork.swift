//
//  AppNetwork.swift
//  RamonBBCChallengeiOSDev
//
//  Created by Ramon Haro Marques on 18/06/2019.
//  Copyright © 2019 Reimond Hill. All rights reserved.
//

import Foundation

class AppNetwork: NSObject{
    
    //MARK:- Properties
    //MARK: Constants
    enum AppNetworkError:Error {
        case dataCorrupted
    }
    
}



//MARK:- Network implementation
extension AppNetwork:Network{
    
    var headlines: String {
        guard let url = Bundle.main.url(forResource: "headlines", withExtension: "json") else{ return ""}
        return url.absoluteString
    }
    
    var headlinesEnhanced: String {
        guard let url = Bundle.main.url(forResource: "headlines-enhanced", withExtension: "json") else{ return ""}
        return url.absoluteString
    }
    
    var analyticsURL: String{
        guard let url = Bundle.main.url(forResource: "analytics", withExtension: nil) else{ return ""}
        return url.absoluteString
    }
    
    
    func fetchCodable<T>(urlRequest: URLRequest, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable, T : Encodable {
        
        guard let url = urlRequest.url else{
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        print("MOCKING...")
        
        do{
            let response = try JSONDecoder().decode(T.self, from: try Data(contentsOf: url))
            completion(.success(response))
        }
        catch{
            print(logClassName, "Error fetching data", error.localizedDescription)
            completion(.failure(error))
        }
        
    }
    
    func fetchData(urlRequest: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        
        //TODO
        
    }
    
    func send(urlRequest: URLRequest, completion: ((Error?) -> Void)?) {
        //TODO
        completion?(nil)
    }
    
}
