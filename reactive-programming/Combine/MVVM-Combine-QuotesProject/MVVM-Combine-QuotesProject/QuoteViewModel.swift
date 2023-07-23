//
//  QuoteViewModel.swift
//  MVVM-Combine-QuotesProject
//
//  Created by Catherine Shing on 7/22/23.
//

import Foundation
import Combine

class QuoteViewModel {
    
    enum Input {
        case viewDidAppear
        case refreshButtonClick
    }
    
    enum Output {
        case fetchQuoteDidFail(error: Error)
        case fetchQuoteDidSucceed(quote: Quote)
        case toggleButton(isEnabled: Bool)
    }
    
    private let quoteServiceType: QuoteServiceType
    private let output: PassthroughSubject<Output, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
    
    init(quoteServiceType: QuoteServiceType = QuoteService()) {
        self.quoteServiceType = quoteServiceType
    }
    
    // processes input events and produces output
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        input.sink { [weak self] event in
            switch event {
            case .viewDidAppear, .refreshButtonClick:
                self?.handleGetRandomQuote()
            }
        }.store(in: &cancellables) // By storing the subscription in cancellables, it ensures that the subscription remains retained and active for as long as it is needed.
        return output.eraseToAnyPublisher()
    }
    
    private func handleGetRandomQuote() {
        output.send(.toggleButton(isEnabled: false))
        quoteServiceType.getRandomQuote().sink { completion in
            self.output.send(.toggleButton(isEnabled: true))
            if case .failure(let error) = completion {
                self.output.send(.fetchQuoteDidFail(error: error))
            }
        } receiveValue: { [weak self] quote in
            self?.output.send(.fetchQuoteDidSucceed(quote: quote))
        }.store(in: &cancellables)
    }
}
