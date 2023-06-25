//
//  Coin.swift
//  MVVM-Example2
//
//  Created by Catherine Shing on 6/24/23.
//

import Foundation

struct Coin {
    
    let id: Int
    let name: String
    let max_supply: Int?
    let cmc_rank: Int
    let quote: Quote
    
    var logoURL: URL? {
        return URL(string: "https://s2.coinmarketcap.com/static/img/coins/200x200/1.png")
    }
    
    struct Quote {
        let USD: USD
        
        struct USD {
            let price: Double
            let market_cap: Double
        }
    }
}

extension Coin {
    
    public static func getMockArray() -> [Coin] {
        return [
            Coin(id: 1, name: "Bitcoin", max_supply: 1000, cmc_rank: 1, quote: Quote(USD: Quote.USD(price: 30000, market_cap: 20000))),
            Coin(id: 2, name: "Ethereum", max_supply: nil, cmc_rank: 2, quote: Quote(USD: Quote.USD(price: 300, market_cap: 5000))),
            Coin(id: 3, name: "Litecoin", max_supply: 1000, cmc_rank: 3, quote: Quote(USD: Quote.USD(price: 20, market_cap: 3000))),
        ]
    }
}
