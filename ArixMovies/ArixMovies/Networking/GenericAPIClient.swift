//
//  GenericAPIClient.swift
//  ArixMovies
//
//  Created by Admin on 27/03/2020.
//  Copyright © 2020 ArixHome. All rights reserved.
//

import Foundation

enum APIError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure
    case invalidURL
    case internalInconsistency
    case unexpectedResultData
    
    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        case .invalidURL: return "Invalid URL"
        case .internalInconsistency: return "Internal Inconsistency"
        case .unexpectedResultData: return "Unexpected result data"
        }
    }
}

protocol APIClient {
    
    var session: URLSession { get }
    func fetch<T: Decodable>(BaseUrlString: String, path: String, queryItems:[String:String], decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void)

}

extension APIClient {
    
    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void
    
    func decodingTask<T: Decodable>(with request: URLRequest, decodingType: T.Type, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
       
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed)
                return
            }
            if httpResponse.statusCode == 200 {
                if let data = data {
                    do {
                        let genericModel = try JSONDecoder().decode(decodingType, from: data)
                         completion(genericModel, nil)
                    } catch {
                        completion(nil, .jsonConversionFailure)
                    }
                } else {
                    completion(nil, .invalidData)
                }
            } else {
                completion(nil, .responseUnsuccessful)
            }
        }
        return task
    }
    
    func fetch<T: Decodable>(BaseUrlString: String, path: String, queryItems:[String:String], decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void) {
        
        guard var components = URLComponents(string: BaseUrlString) else {
            completion(Result.failure(APIError.invalidURL))
            return
        }
        components.path = path
        components.queryItems = queryItems.keys.compactMap{
                URLQueryItem(name: $0, value: queryItems[$0])
        }
        components.queryItems?.append(URLQueryItem(name: "api_key", value: URLs.TMDB.apiKey))
        
        guard let url = components.url else {
            completion(Result.failure(APIError.invalidURL))
            return
        }
        
        let request = URLRequest(url: url)

        let task = decodingTask(with: request, decodingType: T.self) { (json , error) in
            
            //MARK: change to main queue
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        completion(Result.failure(error))
                    } else {
                        completion(Result.failure(.invalidData))
                    }
                    return
                }
                if let value = decode(json) {
                    completion(.success(value))
                } else {
                    completion(.failure(.jsonParsingFailure))
                }
            }
        }
        task.resume()
    }
}

















