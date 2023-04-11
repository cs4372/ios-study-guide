//
//  ViewController.swift
//  PropertyObservers
//
//  Created by Catherine Shing on 4/11/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var showHideButton: UIButton!
    
    var todos = Todo.todoData()
    var filteredTodos = [Todo]()
    var isFiltered = false {
        didSet {
            filteredTodos = isFiltered ? todos.filter { !$0.completed } : todos
            showHideButton.setTitle(isFiltered ? "Show completed" : "Hide Completed", for: .normal)
            tableView.reloadData()
        }
    }

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        filteredTodos = todos
    }
    
    @IBAction func clickShowHideBtn(_ sender: UIButton) {
        isFiltered.toggle()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTodos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TodoCell else {
            fatalError("Could not dequeue cell")
        }
        let todo = filteredTodos[indexPath.row]
        cell.todo = todo
        return cell
    }
}

