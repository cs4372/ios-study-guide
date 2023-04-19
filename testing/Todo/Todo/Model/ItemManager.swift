//
//  ItemManager.swift
//  Todo
//
//  Created by Catherine Shing on 4/17/23.
//

import Foundation

class ItemManager {

    private var todoItems: [TodoItem] = []
    private var doneItems: [TodoItem] = []
    
    var todoCount: Int { return todoItems.count }
    var doneCount: Int { return doneItems.count }
    
    func add(_ item: TodoItem) {
        if !todoItems.contains(item) {
           todoItems.append(item)
         }
    }
    
    func item(at index: Int) -> TodoItem {
      return todoItems[index]
    }
    
    func checkItem(at index: Int) {
        
        let item = todoItems.remove(at: index)
        doneItems.append(item)
    }
    
    func doneItem(at index: Int) -> TodoItem {
      return doneItems[index]
    }
    
    func removeAll() {
        todoItems.removeAll()
        doneItems.removeAll()
    }
}
