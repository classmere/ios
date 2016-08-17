//
//  InfoTableViewCell2.swift
//  classmereApp
//
//  Created by Brandon Lee on 11/14/15.
//  Copyright © 2015 Brandon Lee. All rights reserved.
//

import UIKit

/**
 Third detailed cell with course information in section view.
 Displays the following course information:
 - Course Capacity
 - Course Currently Enrolled
 - Course CRN
 */
class InfoTableViewCell2: AbstractClassmereCell {

    @IBOutlet weak var capacityLabel: UILabel!
    @IBOutlet weak var currentlyEnrolledLabel: UILabel!
    @IBOutlet weak var availableSpotsLabel: UILabel!
    @IBOutlet weak var crnLabel: UILabel!
    
    /**
     Fill cell with specific course data.
     
     - Parameter course: The section object.
     - Returns: Nothing.
     */
    func populateWithCourse(section: CourseSection) {
        if let capacity = section.enrollmentCapacity {
            capacityLabel.text = String(capacity)
        }
        
        if let currentEnrolled = section.enrollmentCurrent {
            currentlyEnrolledLabel.text = String(currentEnrolled)
        }
        
        if section.enrollmentCapacity != nil && section.enrollmentCurrent != nil {
            availableSpotsLabel.text = String(Int(section.enrollmentCapacity!)! - Int(section.enrollmentCurrent!)!)
        } else {
            availableSpotsLabel.text = ""
        }
        
        if let crn = section.crn {
            crnLabel.text = String(crn)
        }
    }
}
