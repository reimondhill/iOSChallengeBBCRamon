//
//  MockNetwork.swift
//  RamonBBCChallengeiOSTests
//
//  Created by Ramon Haro Marques on 19/06/2019.
//  Copyright © 2019 Reimond Hill. All rights reserved.
//

import Foundation
@testable import RamonBBCChallengeiOS

class MockNetwork: NSObject, Network{
    
    //MARK:- Properties
    //MARK: Constants
    enum AppNetworkError:Error {
        case dataCorrupted
    }
    
    //MARK:- Network implementation
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
        
        print(url)
        
        do{
            let response = try JSONDecoder().decode(T.self, from: try Data(contentsOf: url))
            completion(.success(response))
        }
        catch{
            print(logClassName, "Error fetching data", error.localizedDescription)
            completion(.failure(error))
        }
        
    }
    
    func send(params: [(String, String)], urlString: String, requestType: RequestType, completion: ((Result<Data, Error>) -> Void)?) {
        
        print(logClassName, "urlString = ", urlString)
        
        guard var urlComponents = URLComponents(string: urlString) else{
            completion?(.failure(NetworkError.invalidURL))
            return
        }
        
        urlComponents.queryItems = []
        for (key, value) in params{
            urlComponents.queryItems?.append(URLQueryItem(name: key, value: value))
        }
        
        let rtString = urlComponents.url?.relativeString ?? ""
        completion?(.success(rtString.data(using: .utf8) ?? Data()))
        
        
    }
    
}
