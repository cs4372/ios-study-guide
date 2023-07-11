//
//  UserError.swift
//  CurrentValueSubject
//
//  Created by Catherine Shing on 7/10/23.
//

import Foundation

enum UserError: Error {
    case invalid
}

extension UserError {
    
    public var errorDescription: String {
        switch self {
        case .invalid:
            return "Form is invalid"
        }
    }
}
