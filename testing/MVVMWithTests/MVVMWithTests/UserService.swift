//
//  UserService.swift
//  MVVMWithTests
//
//  Created by Catherine Shing on 7/8/23.
//

import Foundation

protocol UserService {
  func fetchUser(completion: @escaping (Result<User, Error>) -> Void)
}

class APIManager: UserService {
  
  func fetchUser(completion: @escaping (Result<User, Error>) -> Void) {
    
    let url = URL(string: "https://reqres.in/api/users/3")!
    
    URLSession.shared.dataTask(with: url) { data, res, error in
      guard let data = data else { return }
      DispatchQueue.main.async {
        if let user = try? JSONDecoder().decode(UserResponse.self, from: data).data {
          completion(.success(user))
        } else {
          completion(.failure(NSError()))
        }
      }
    }.resume()
  }
}
