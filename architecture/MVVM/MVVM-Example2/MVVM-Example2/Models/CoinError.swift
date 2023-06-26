//
//  CoinError.swift
//  MVVM-Example2
//
//  Created by Catherine Shing on 6/25/23.
//

import Foundation

struct CoinStatus: Decodable {
    let status: CoinError
}

struct CoinError: Decodable {
    let errorCode: Int
    let errorMessage: String
    
    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case errorMessage = "error_message"
    }
}
