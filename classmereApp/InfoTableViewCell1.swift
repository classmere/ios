//
//  InfoTableViewCell1.swift
//  classmereApp
//
//  Created by Brandon Lee on 11/14/15.
//  Copyright © 2015 Brandon Lee. All rights reserved.
//

import UIKit

/**
 Second detailed cell with course information in section view.
 Displays the following course information:
 - Course Instructor
 - Course Term
 - Course Type
 */
class InfoTableViewCell1: AbstractClassmereCell {
    
    @IBOutlet weak var instructorLabel: UILabel!
    @IBOutlet weak var termLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    /**
     Fill cell with specific course data.
     
     - Parameter course: The section object.
     - Returns: Nothing.
     */
    func populateWithCourse(section: CourseSection) {
        instructorLabel.text = section.instructor
        termLabel.text = section.term
        typeLabel.text = section.type
    }
}
