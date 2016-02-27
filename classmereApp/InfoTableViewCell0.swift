//
//  InfoTableViewCell0.swift
//  classmereApp
//
//  Created by Brandon Lee on 11/14/15.
//  Copyright © 2015 Brandon Lee. All rights reserved.
//

import UIKit

/**
 First detailed cell with course information in section view.
 Displays the following course information:
 - Course Title
 - Course Building Data
 - Course Time
 - Course Day
 */
class InfoTableViewCell0: AbstractClassmereCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var buildingLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    
    /**
     Fill cell with specific course data.
     
     - Parameter course: The course object.
     - Paramter section: The section object.
     - Returns: Nothing.
     */
    func populateWithCourse(course: Course, section: CourseSection) {
        titleLabel.text = course.title?.capitalizedString
        timeLabel.text = InfoTableViewCell0.formatCourseTime(course)
        buildingLabel.text = InfoTableViewCell0.formatBuildingStringWithSection(section)
        dayLabel.text = section.days
        super.awakeFromNib()
    }
}
