//
//  UserViewModel.swift
//  MVVMWithTests
//
//  Created by Catherine Shing on 7/8/23.
//

import Foundation

class UserViewModel {
    
    weak var output: UserViewModelOutput?
    private let userService: UserService
    
    init(userService: UserService) {
        self.userService = userService
    }
    
    func fetchUser() {
        userService.fetchUser { [weak self] result in
            switch result {
            case .success(let user):
                self?.output?.updateView(imageUrl: user.avatar, email: user.email)
            case .failure:
                let errorImageUrl = "https://cdn1.iconfinder.com/data/icons/user-fill-icons-set/144/User003_Error-1024.jpg"
                self?.output?.updateView(imageUrl: errorImageUrl, email: "No user found")
            }
        }
    }
    
}
