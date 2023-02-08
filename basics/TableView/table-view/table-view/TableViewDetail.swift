//
//  TableViewDetail.swift
//  table-view
//
//  Created by Catherine Shing on 2/7/23.
//

import UIKit

class TableViewDetail: UIViewController {
    @IBOutlet weak var hotelName: UILabel!
    @IBOutlet weak var hotelLocation: UILabel!
    @IBOutlet weak var imageName: UIImageView!
    
    var selectedHotel: Hotel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hotelName.text = selectedHotel.id + ". " + selectedHotel.name
        hotelLocation.text = selectedHotel.location
        imageName.image = UIImage(named: selectedHotel.imageName)
    }
}
