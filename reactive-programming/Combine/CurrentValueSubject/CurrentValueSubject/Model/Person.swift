//
//  Person.swift
//  CurrentValueSubject
//
//  Created by Catherine Shing on 7/10/23.
//

import Foundation

struct Person {
    var firstName: String
    var lastName: String
    var occupation: String
}

extension Person {
   
    var message: String {
        "\(firstName) \(lastName) is a \(occupation)"
    }
    
    var isValid: Bool {
        !firstName.isEmpty && !lastName.isEmpty && !occupation.isEmpty
    }
}
