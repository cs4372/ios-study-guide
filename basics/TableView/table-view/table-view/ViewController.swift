//
//  ViewController.swift
//  table-view
//
//  Created by Catherine Shing on 2/6/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var hotelTableView: UITableView!
    
    var hotels = ["Ritz", "Indigo", "Four Seasons", "Hyatt", "Holiday Inn"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        hotelTableView.delegate = self
        hotelTableView.dataSource = self
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected \(hotels[indexPath.row])")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hotels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
        cell.textLabel?.text = hotels[indexPath.row]
        return cell
    }
}
