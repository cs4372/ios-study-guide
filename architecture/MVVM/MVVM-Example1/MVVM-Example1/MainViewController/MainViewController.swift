//
//  MainViewController.swift
//  MVVM-Example1
//
//  Created by Catherine Shing on 6/22/23.
//

import UIKit

class MainViewController: UIViewController {
        
    @IBOutlet weak var tableView: UITableView!
    
    //Reference to ViewModel
    var viewModel: MainViewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configView()

    }
    
    func configView() {
        self.title = "Main View"
        self.view.backgroundColor = .systemBlue
        
        setupTableView()
    }
}
