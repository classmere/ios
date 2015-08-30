//
//  Course.swift
//  classmereApp
//
//  Created by Brandon Lee on 8/25/15.
//  Copyright (c) 2015 Brandon Lee. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

struct Course {
    let title: String?
    let abbr: String?
    let credits: String?
    let description: String?
    let sections: [String: AnyObject]?
    
    init(courseJSON: JSON) {
        title = courseJSON["title"].string as String?
        abbr = courseJSON["abbr"].string as String?
        credits = courseJSON["credits"].string as String?
        description = courseJSON["description"].string as String?
        sections = courseJSON["sections"].dictionaryObject as [String: AnyObject]?
    }
}
