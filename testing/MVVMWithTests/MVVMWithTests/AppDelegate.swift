//
//  AppDelegate.swift
//  MVVMWithTests
//
//  Created by Catherine Shing on 7/8/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let userService: UserService = APIManager()
        let viewModel = UserViewModel(userService: userService)
        window?.backgroundColor = .blue
        window?.rootViewController = UserViewController(viewModel: viewModel)
        window?.makeKeyAndVisible()
        
        return true
    }
}

