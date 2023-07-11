//
//  AccountViewModel.swift
//  PassThroughSubjects
//
//  Created by Catherine Shing on 7/10/23.
//

import Foundation
import Combine

final class AccountViewModel {
    
    enum AccountStatus {
        case active
        case banned
    }
    
    private let warningLimit = 3
    
    let userAccountstatus = CurrentValueSubject<AccountStatus, Never>(.active)
    let warnings = CurrentValueSubject<Int, Never>(0)
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        createSubscription()
    }
    
    func increaseWarning() {
        warnings.value += 1
        print("Warning: \(warnings.value)")
    }
    
}

private extension AccountViewModel {
    
    func createSubscription() {
        
        warnings
            .filter({ [weak self] val in
                
                guard let self = self else { return false }
                return val >= self.warningLimit
            })
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.userAccountstatus.value = .banned
            }
            .store(in: &subscriptions)
    }
}
