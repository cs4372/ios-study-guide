//
//  User.swift
//  MVVMWithTests
//
//  Created by Catherine Shing on 7/8/23.
//

import Foundation

struct UserResponse: Decodable {
  let data: User
}

struct User: Decodable {
  let id: Int
  let email: String
  let avatar: String
}
