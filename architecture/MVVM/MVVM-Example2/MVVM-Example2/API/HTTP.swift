//
//  HTTP.swift
//  MVVM-Example2
//
//  Created by Catherine Shing on 6/25/23.
//

import Foundation

enum HTTP {
    
    enum Method: String {
        case get = "GET"
        case post = "POST"
    }
    
    enum Headers {
        
        // Most of the time we don't need to provide contentType and application Json in GET request. It's more common in POST, PATCH, etc
        enum Key: String {
            case contentType = "Content-Type"
            case apiKey = "X-CMC_PRO_API_KEY"
        }
        
        enum Value: String {
            case applicationJson = "application/json"
        }
    }
}
