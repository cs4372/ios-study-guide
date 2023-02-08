//
//  ViewController.swift
//  table-view
//
//  Created by Catherine Shing on 2/6/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var hotelTableView: UITableView!
    
    var hotels = [Hotel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        hotelTableView.delegate = self
        hotelTableView.dataSource = self
        renderHotelData()
    }
    
    func renderHotelData() {
        let hotel1 = Hotel(id: "1", name: "Ritz", imageName: "andaz", location: "Germany")
        hotels.append(hotel1)

        let hotel2 = Hotel(id: "2", name: "Four Seasons", imageName: "fourseasons_budapest", location: "Budapest")
        hotels.append(hotel2)

        let hotel3 = Hotel(id: "3", name: "Royal Mansour", imageName: "royal_mansour", location: "Morocco")
        hotels.append(hotel3)

        let hotel4 = Hotel(id: "4", name: "The Silo", imageName: "the_silo", location: "South Africa")
        hotels.append(hotel4)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hotels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! TableViewCell
        let hotel = hotels[indexPath.row]
        cell.hotelName?.text = hotel.id + ". " + hotel.name
        cell.hotelLocation?.text = hotel.location
        cell.imageName?.image = UIImage(named: hotel.imageName)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "detailSegue") {
            let indexPath = self.hotelTableView.indexPathForSelectedRow!
            let tableViewDetail = segue.destination as? TableViewDetail
            let selectedHotel = hotels[indexPath.row]
            tableViewDetail!.selectedHotel = selectedHotel
            self.hotelTableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
