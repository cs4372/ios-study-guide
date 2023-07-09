//
//  UserViewModelOutput.swift
//  MVVMWithTests
//
//  Created by Catherine Shing on 7/8/23.
//

import Foundation

protocol UserViewModelOutput: AnyObject {
  func updateView(imageUrl: String, email: String)
}
