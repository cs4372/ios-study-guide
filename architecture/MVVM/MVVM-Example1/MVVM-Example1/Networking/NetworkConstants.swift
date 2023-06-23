//
//  NetworkConstants.swift
//  MVVM-Example1
//
//  Created by Catherine Shing on 6/22/23.
//

import Foundation

class NetworkConstants {
    public static var shared: NetworkConstants = NetworkConstants()
    
    private init() {
        
    }
    
    public var apiKey: String {
        get {
            if let path = Bundle.main.path(forResource: "APIKeys", ofType: "plist") {
                if let keys = NSDictionary(contentsOfFile: path) as? [String: Any],
                    let apiKey = keys["APIKey"] as? String {
                    return apiKey
                }
            }
            return ""
        }
    }
    
    public var serverAddress: String {
        get {
            return "https://api.themoviedb.org/3/"
        }
    }
    
    public var imageServerAddress: String {
        get {
            return "https://image.tmdb.org/t/p/w500/"
        }
    }
}
