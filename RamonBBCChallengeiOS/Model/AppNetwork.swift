//
//  AppNetwork.swift
//  RamonBBCChallengeiOS
//
//  Created by Ramon Haro Marques on 18/06/2019.
//  Copyright © 2019 Reimond Hill. All rights reserved.
//

import Foundation


class AppNetwork:Network{
    
    var headlines: String{
        return "https://raw.githubusercontent.com/bbc/news-apps-coding-challenge/master/headlines.json"
    }
    var headlinesEnhanced: String{
        return "https://raw.githubusercontent.com/bbc/news-apps-coding-challenge/master/headlines-enhanced.json"
    }
    var analyticsURL: String{
        return"https://raw.githubusercontent.com/bbc/news-apps-ios-coding-challenge/master/analytics"
    }
    
    
    func fetchCodable<T>(urlRequest: URLRequest, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable, T : Encodable {
        
        guard urlRequest.url != nil else{
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.requestCachePolicy = .reloadIgnoringLocalCacheData
        
        let startTime = DispatchTime.now().uptimeNanoseconds / 1_000_000
        let urlSession = URLSession(configuration: sessionConfig)
        urlSession.dataTask(with: urlRequest) { (data, response, error) in
            
            let totalTime = DispatchTime.now().uptimeNanoseconds / 1_000_000 - startTime
            print("Request finished in ", totalTime," ms.")
            AnalyticsHelper.sendLoadAnalyticsEvent(time: totalTime, network: self, completion: nil)
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data,
                let response = response as? HTTPURLResponse,
                (200 ..< 300) ~= response.statusCode else{
                    
                    completion(.failure(NetworkError.dataCorrupted))
                    return
                    
            }
            
            do {
                let response = try JSONDecoder().decode(T.self, from: data)
                completion(.success(response))
            }
            catch let decodeError{
                completion(.failure(decodeError))
            }
            
            }.resume()
        
    }
    
    func fetchData(urlRequest: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
            }
            
            guard let data = data else{
                completion(.failure(NetworkError.dataCorrupted))
                return
            }
            
            completion(.success(data))
            
            }.resume()
        
    }
    
    func send(urlRequest: URLRequest, completion: ((Error?) -> Void)?) {
        
        guard urlRequest.url != nil else{
            completion?(NetworkError.invalidURL)
            return
        }
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.requestCachePolicy = .reloadIgnoringLocalCacheData
        
        print("Sending request to: ", urlRequest.url!)
        let urlSession = URLSession(configuration: sessionConfig)
        urlSession.dataTask(with: urlRequest) { (data, response, error) in
            
            if let error = error {
                completion?(error)
                return
            }
            
            //Ignoring data back by now
            guard let response = response as? HTTPURLResponse,
                (200 ..< 300) ~= response.statusCode else{
                    completion?(NetworkError.dataCorrupted)
                    return
            }
            
            completion?(nil)
            
            }.resume()
        
    }
    
}
