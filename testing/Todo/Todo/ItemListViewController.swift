//
//  ItemListViewController.swift
//  Todo
//
//  Created by Catherine Shing on 4/18/23.
//

import UIKit
 
class ItemListViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var dataProvider: (UITableViewDataSource & UITableViewDelegate)!

    override func viewDidLoad() {
       super.viewDidLoad()

      tableView = UITableView()
      tableView.delegate = dataProvider
      tableView.dataSource = dataProvider
    }
}
