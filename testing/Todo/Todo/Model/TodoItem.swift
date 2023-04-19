//
//  TodoItem.swift
//  Todo
//
//  Created by Catherine Shing on 4/16/23.
//

import Foundation

struct TodoItem: Equatable {
    let title: String
    let itemDescription: String?
    let timestamp: TimeInterval?
    let location: Location?
    
    init(title: String, itemDescription: String? = nil, timestamp: TimeInterval? = nil, location: Location? = nil) {
        self.title = title
        self.itemDescription = itemDescription
        self.timestamp = timestamp
        self.location = location
    }
}

func ==(lhs: TodoItem, rhs: TodoItem) -> Bool {
    if lhs.location?.name != rhs.location?.name {
        return false
  }
    if lhs.itemDescription != rhs.itemDescription {
        return false
    }
  return true
}
