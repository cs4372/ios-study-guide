//
//  Todo.swift
//  PropertyObservers
//
//  Created by Catherine Shing on 4/11/23.
//

import UIKit

struct Todo {
    var title: String
    var completed: Bool = false
    
    static func todoData() -> [Todo] {
        return [
            Todo(title: "Water plants"),
            Todo(title: "Finish project"),
            Todo(title: "Order food", completed: true),
            Todo(title: "Clean bathroom"),
            Todo(title: "Vaccum floor"),
            Todo(title: "Call bank", completed: true),
            Todo(title: "Go to petstore")
        ]
    }
}
