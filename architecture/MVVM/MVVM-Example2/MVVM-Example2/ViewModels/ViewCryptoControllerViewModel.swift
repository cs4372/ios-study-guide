//
//  ViewCryptoControllerViewModel.swift
//  MVVM-Example2
//
//  Created by Catherine Shing on 6/25/23.
//

import UIKit

class ViewCryptoControllerViewModel  {
        
    // MARK: - Variables
    let coin: Coin
    
    // MARK: - Initializer

    init(_ coin: Coin) {
        self.coin = coin
    }
    
    var rankLabel: String {
        return "Rank: \(self.coin.rank)"
    }
    
    var priceLabel: String {
        return "Price: $\(self.coin.pricingData.USD.price)"
    }
    
    var marketCapLabel: String {
        return "Market Cap: $\(self.coin.pricingData.USD.market_cap)"
    }
    
    var maxSupplyLabel: String {
        if let maxSupply = self.coin.maxSupply {
            return "Max Supply: \(maxSupply)"
        }
        return "123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n"
    }
}
