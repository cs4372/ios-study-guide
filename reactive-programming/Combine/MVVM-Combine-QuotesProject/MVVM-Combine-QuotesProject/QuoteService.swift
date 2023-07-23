//
//  QuoteService.swift
//  MVVM-Combine-QuotesProject
//
//  Created by Catherine Shing on 7/23/23.
//

import Foundation
import Combine

protocol QuoteServiceType {
    func getRandomQuote() -> AnyPublisher<Quote, Error>
}

class QuoteService: QuoteServiceType {
    func getRandomQuote() -> AnyPublisher<Quote, Error> {
        guard let url = URL(string: "https://api.quotable.io/random") else {             return Fail(error: URLError(.badURL)).eraseToAnyPublisher() }
        return URLSession.shared.dataTaskPublisher(for: url)
            .catch { error in
                return Fail(error: error).eraseToAnyPublisher()
            }.map({ $0.data })
            .decode(type: Quote.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
