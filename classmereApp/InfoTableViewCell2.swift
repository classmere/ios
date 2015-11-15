//
//  InfoTableViewCell2.swift
//  classmereApp
//
//  Created by Brandon Lee on 11/14/15.
//  Copyright © 2015 Brandon Lee. All rights reserved.
//

import UIKit

class InfoTableViewCell2: AbstractClassmereCell {

    @IBOutlet weak var capacityLabel: UILabel!
    
    func populateWithCourse(course: Course) {
        let section = course.courseSections[0]
        capacityLabel.text = String(section.capacity)
    }

}
