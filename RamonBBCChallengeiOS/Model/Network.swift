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

enum RequestType:String{
    case get = "GET"
    case post = "POST"
}

protocol NetworkURL {
    
    ///StringURL for fetching headlines
    var headlines:String{get}
    ///StringURL for fetching a headlins enhanced
    var headlinesEnhanced:String{get}
    ///String URL for analytics service
    var analyticsURL:String{get}
}

protocol Network:NetworkURL {
    
    /// Perform GET/POST request returning the result decoded object
    ///
    /// - Parameters:
    ///   - urlRequest: Url request with the request config
    ///   - completion: Result type handler called the request has finished.
    func fetchCodable<T:Codable>(urlRequest:URLRequest, completion:@escaping (Result<T,Error>)->Void)
    
    /// Send HTTP data
    ///
    /// - Parameters:
    ///   - params: Key value for the params to send
    ///   - url: String of the url reques
    ///   - requestType: Method used to send the values. GET, POST.
    ///   - completion: handler called when data is successfully sent and response received
    func send(params:[String:String], urlString:String, requestType: RequestType, completion:( (Result<Data,Error>)->Void )?)
    
}
