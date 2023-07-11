//
//  CommentsViewModel.swift
//  PassThroughSubjects
//
//  Created by Catherine Shing on 7/10/23.
//

import Foundation
import Combine

final class CommentsViewModel {
    
    // PassthroughSubject only emits events. It does not observe any changes.
    // Never fails, hence set to Never
    private let commentEntered = PassthroughSubject<String, Never>()
    private var subscriptions = Set<AnyCancellable>()
    
    private let words = ["Dusty", "Cat", "Teddy"]
    
    private let accountVM: AccountViewModel
    
    init(accountVM: AccountViewModel) {
        self.accountVM = accountVM
        setupSubscriptions()
    }

    func send(comment: String) {
        commentEntered.send(comment)
    }
}

private extension CommentsViewModel {
    
    func setupSubscriptions() {
        
        commentEntered
            .filter({ !$0.isEmpty })
            .sink { [weak self] val in
                
                guard let self = self else { return }
                
                if self.words.contains(val) {
                    self.accountVM.increaseWarning()
                } else {
                    print("New comment: \(val)")
                }
            }
            .store(in: &subscriptions)
    }
}
