//
//  ViewCryptoControllerViewModel.swift
//  MVVM-Example2
//
//  Created by Catherine Shing on 6/25/23.
//

import UIKit

class ViewCryptoControllerViewModel  {
    
    var onImageLoaded: ((UIImage?) -> Void)?
    
    // MARK: - Variables
    let coin: Coin
    
    // MARK: - Initializer

    init(_ coin: Coin) {
        self.coin = coin
        self.loadImage()
    }
    
    private func loadImage() {
        DispatchQueue.global().async { [weak self] in
            if let logoURL = self?.coin.logoURL,
               let imageData = try? Data(contentsOf: logoURL),
               let logoImage = UIImage(data: imageData) {
                self?.onImageLoaded?(logoImage)
            }
        }
    }
    
    var rankLabel: String {
        return "Rank: \(self.coin.cmc_rank)"
    }
    
    var priceLabel: String {
        return "Price: \(self.coin.quote.USD.price)"
    }
    
    var marketCapLabel: String {
        return "Market Cap: \(self.coin.quote.USD.market_cap)"
    }
    
    var maxSupplyLabel: String {
        if let maxSupply = self.coin.max_supply {
            return "Max Supply: \(maxSupply)"
        }
        return "123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n"
    }
}
