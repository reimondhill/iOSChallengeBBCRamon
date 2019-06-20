//
//  AppNetwork.swift
//  RamonBBCChallengeiOS
//
//  Created by Ramon Haro Marques on 18/06/2019.
//  Copyright © 2019 Reimond Hill. All rights reserved.
//

import Foundation


class AppNetwork:NSObject, Network{
    
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
        
        //Technically the analytics are send only when fetch action. It can be moved to performRequest func
        let startTime = DispatchTime.now().uptimeNanoseconds / 1_000_000
        performRequest(urlRequest) { [weak self] (result) in
            
            guard let strongSelf = self else { return }
            
            let totalTime = DispatchTime.now().uptimeNanoseconds / 1_000_000 - startTime
            print(strongSelf.logClassName,"Request finished in ", totalTime," ms.")
            AnalyticsHelper.sendLoadAnalyticsEvent(time: totalTime, network: strongSelf, completion: nil)
            
            switch result{
                
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(response))
                }
                catch let decodeError{
                    completion(.failure(decodeError))
                }
                
            case .failure(let error):
                completion(.failure(error))
                
            }
            
        }
        
    }
    
    func send(params: [(String, String)], urlString: String, requestType: RequestType, completion: ((Result<Data, Error>)->Void)?) {
        
        guard var urlComponents = URLComponents(string: urlString) else{
            completion?(.failure(NetworkError.invalidURL))
            return
        }
        
       urlComponents.queryItems = []
        for (key, value) in params{
            urlComponents.queryItems?.append(URLQueryItem(name: key, value: value))
        }
        
        guard let url = urlComponents.url else{
            completion?(.failure(NetworkError.invalidURL))
            return
        }
        
        print(logClassName, "Sending request to: ", url)
        performRequest(URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 5)) { [weak self](result) in
            
            guard let strongSelf = self else { return }
            
            switch result{
                
            case .success(let data):
                print(strongSelf.logClassName, "request sent: Success")
                completion?(.success(data))
            case .failure(let error):
                print(strongSelf.logClassName, "request sent: Error = ", error)
                completion?(.failure(error))
            
            }
            
        }
        
    }

}


//MARK:- Private methods
private extension AppNetwork{
    
    func performRequest(_ urlRequest: URLRequest, completion: @escaping ((Result<Data, Error>)->Void) ){
        
        guard urlRequest.url != nil else{
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.requestCachePolicy = .reloadIgnoringLocalCacheData
        
        let urlSession = URLSession(configuration: sessionConfig)
        urlSession.dataTask(with: urlRequest) { (data, response, error) in
            
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
            
            completion(.success(data))
        
        }.resume()
    
    }
    
}
