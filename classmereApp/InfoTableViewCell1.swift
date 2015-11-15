//
//  InfoTableViewCell1.swift
//  classmereApp
//
//  Created by Brandon Lee on 11/14/15.
//  Copyright © 2015 Brandon Lee. All rights reserved.
//

import UIKit

class InfoTableViewCell1: AbstractClassmereCell {
    
    @IBOutlet weak var instructorLabel: UILabel!
    
    func populateWithCourse(course: Course) {
        let section = course.courseSections[0]
        instructorLabel.text = section.instructor
    }

}
