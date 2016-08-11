//
//  Building.swift
//  Classmere
//
//  Created by Brandon Lee on 8/10/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import Foundation
import SwiftyJSON

/**
 A model representation of a building at OSU.
 Reference Docs - https://github.com/classmere/api
 */
struct Building {
    let abbr: String?
    let address: String?
    let buildingNumber: String?
    let name: String?
    let sqft: String?
    
    init(buildingJSON: JSON) {
        abbr = buildingJSON["abbr"].string as String?
        address = buildingJSON["address"].string as String?
        buildingNumber = buildingJSON["buildingNumber"].string as String?
        name = buildingJSON["name"].string as String?
        sqft = buildingJSON["sqft"].string as String?
    }
}