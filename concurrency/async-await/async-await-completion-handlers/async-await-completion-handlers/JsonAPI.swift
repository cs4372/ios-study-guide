//
//  JsonAPI.swift
//  async-await-completion-handlers
//
//  Created by Catherine Shing on 8/23/23.
//

import Foundation

enum customError: Error {
    case invalidURL(reason:String)
    case decodingError(reason:String)
}

class JsonAPI {
    typealias PostAPIResult = Result<[Post], Error>
    
    static let postURL = URL(string: "https://jsonplaceholder.typicode.com/posts/")

    static func loadPosts(completion: @escaping (PostAPIResult) -> ()) {
        if let postURL {
            let request = URLRequest(url: postURL)
            URLSession.shared.dataTask(with: request) { data, _, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    print("No data was returned")
                    return
                }
                
                do {
                    let posts = try JSONDecoder().decode([Post].self, from: data)
                    completion(.success(posts))
                } catch {
                    completion(.failure(customError.decodingError(reason: "Decoding error")))
                }
            }.resume()
        }
    }
    
    static func loadPostsAsync() async throws -> [Post] {
        guard let postURL = postURL else {
            throw customError.invalidURL(reason: "invalid URL")
        }
        let request = URLRequest(url: postURL)
        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode([Post].self, from: data)
        return response
    }
}
