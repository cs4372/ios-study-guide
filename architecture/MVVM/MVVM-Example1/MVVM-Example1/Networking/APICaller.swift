//
//  APICaller.swift
//  MVVM-Example1
//
//  Created by Catherine Shing on 6/23/23.
//

import Foundation

enum NetworkError: Error {
    case urlError
    case parsingError
}

public class APICaller {
    static func getTrendingMovies(completeHandler: @escaping (_ result: Result<TrendingMoviesModel, NetworkError>) -> Void ) {
        
        let urlString = NetworkConstants.shared.serverAddress + "trending/all/day?api_key=" + NetworkConstants.shared.apiKey
        
        guard let url = URL(string: urlString) else {
            completeHandler(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, error in
            if error == nil, let data = dataResponse, let resultData = try? JSONDecoder().decode(TrendingMoviesModel.self, from: data) {
                completeHandler(.success(resultData))
                
            } else {
                completeHandler(.failure(.parsingError))
            }
            
        }.resume()
    }
}
