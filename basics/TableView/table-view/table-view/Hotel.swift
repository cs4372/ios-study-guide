//
//  Hotel.swift
//  table-view
//
//  Created by Catherine Shing on 2/7/23.
//

import UIKit

class Hotel {
    var id: String!
    var name: String!
    var imageName: String!
    var location: String!
    
    public init(id: String, name: String, imageName: String, location: String) {
        self.id = id
        self.name = name
        self.imageName = imageName
        self.location = location
    }
}
