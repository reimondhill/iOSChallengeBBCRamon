//
//  Network.swift
//  RamonBBCChallengeiOS
//
//  Created by Ramon Haro Marques on 18/06/2019.
//  Copyright © 2019 Reimond Hill. All rights reserved.
//

import Foundation


enum NetworkError:Error {
    case dataCorrupted
    case invalidURL
}

protocol NetworkURL {
    
    ///StringURL for fetching headlines
    var headlines:String{get}
    ///StringURL for fetching a headline detail
    var headlinesEnhanced:String{get}

}

protocol Network:NetworkURL {
    
    /// Perform GET/POST request returning the result decoded object
    ///
    /// - Parameters:
    ///   - urlRequest: Url request with the request config
    ///   - completion: Result type handler called the request has finished.
    func fetchCodable<T:Codable>(urlRequest:URLRequest, completion:@escaping (Result<T,Error>)->Void)
    
    /// Perform GET/POST request returning the result decoded object
    ///
    /// - Parameters:
    ///   - urlRequest: Url request with the request config
    ///   - completion: Result type handler called the request has finished.
    func fetchData(urlRequest:URLRequest, completion:@escaping (Result<Data,Error>)->Void)
    
    /// Send HTTP data
    ///
    /// - Parameters:
    ///   - urlRequest: Url request with the request config
    ///   - completion: handler called when data is successfully sent and response received
    func send(data:Data, urlRequest:URLRequest, completion:@escaping (Error?)->Void)
    
}
