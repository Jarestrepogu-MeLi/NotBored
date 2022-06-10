//
//  NetworkManager.swift
//  NotBored
//
//  Created by Jorge Andres Restrepo Gutierrez on 7/06/22.
//

import Foundation

struct NetworkManager{
    
    enum CustomError: Error {
        case invalidUrl
        case invalidData
        case noActivityFound
    }
    
    let page: String = ""
    
    private func searchActivityURL(participants: Int, type: String?) -> URL {
        var url = URLComponents()
        url.host = "www.boredapi.com"
        url.scheme = "http"
        url.path = "/api/activity"
        if let safeType = type {
            url.queryItems = [
                URLQueryItem(name: "participants", value: String(participants)),
                URLQueryItem(name: "type", value: safeType)
            ]
        } else {
            url.queryItems = [
                URLQueryItem(name: "participants", value: String(participants))
            ]
        }
        return URL(string: url.string!)!
    }
    
    private func request <T: Decodable> (url: URL?, expecting: T.Type, completionHandler: @escaping (Result<T, Error>) -> Void) {
        
        guard let url = url else {
            completionHandler(.failure(CustomError.invalidUrl))
            return
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, _, error in
            guard let data = data else {
                if let error = error {
                    completionHandler(.failure(error))
                } else {
                    completionHandler(.failure(CustomError.invalidData))
                }
                return
            }
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(expecting, from: data)
                completionHandler(.success(result))
            }
            catch {
                completionHandler(.failure(error))
            }
        }
        task.resume()
    }
    
    func fetchActivity (with participants: Int, type: String?, completion: @escaping (Result<Activity, Error>) -> Void) {
        let url = searchActivityURL(participants: participants, type: type)
        request(url: url, expecting: Activity.self, completionHandler: completion)
    }
}
