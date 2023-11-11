//
//  NetworkManager.swift
//  PopularMovies
//
//  Created by Mubasher Khan on 11/11/23.
//

import Foundation
import Combine


protocol NetworkManagerProtocol {
    func getMethod<T>(url: String, params: [String: Any]) -> AnyPublisher<T, Error> where T: Decodable
}

class NetworkManager:NetworkManagerProtocol {
    static let shared = NetworkManager()
    
    func getMethod<T>(url: String, params: [String: Any]) -> AnyPublisher<T, Error> where T: Decodable {
        let memoryCapacity = 10 * 1024 * 1024
        let diskCapacity = 200 * 1024 * 1024
        let urlCache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "popular-movies")
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.urlCache = urlCache
        let session = URLSession(configuration: sessionConfig)
        
        guard let url = URL(string: url) else {
            let error = URLError(.badURL)
            return Fail(error: error).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url,cachePolicy: .returnCacheDataElseLoad)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["Authorization": Constants.TMDB_SECRET]
        if let queryParams = params.compactMap({ "\($0.key)=\($0.value)" }).joined(separator: "&").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            request.url = URL(string: "\(url.absoluteString)?\(queryParams)")
        }

        return session.dataTaskPublisher(for: request)
            .tryMap { data, response -> T in
                if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                    throw URLError(.badServerResponse)
                }
                return try JSONDecoder().decode(T.self, from: data)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
