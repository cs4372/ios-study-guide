//
//  Constants.swift
//  MVVM-Example2
//
//  Created by Catherine Shing on 6/24/23.
//

import Foundation

struct Constants {
    
    // MARK: - API
    
    static let scheme = "https"
    static let baseURL = "pro-api.coinmarketcap.com"
    static let port: Int? = nil
    static let fullURL = "https://pro-api.coinmarketcap.com"
    
    static var API_KEY: String {
          if let path = Bundle.main.path(forResource: "APIKey", ofType: "plist") {
              if let keys = NSDictionary(contentsOfFile: path) as? [String: Any],
                  let apiKey = keys["CoinMarketCapAPIKey"] as? String {
                  return apiKey
              }
          }
          return ""
      }
}
