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
     - Returns: Nothing.
     */
    func populateWithCourse(course: Course) {
        let section = course.courseSections[0]
        titleLabel.text = course.title?.capitalizedString
        timeLabel.text = InfoTableViewCell0.formatCourseTime(course)
        buildingLabel.text = InfoTableViewCell0.formatBuildingStringWithSection(section)
        dayLabel.text = section.days
        super.awakeFromNib()
    }
    
    /**
     Formats the course time to combine start time and end time into one string.
     
     - Paramter course: The course object.
     - Returns: Formatted time string
     */
    static func formatCourseTime(course: Course) -> String {
        if let startTime = course.courseSections[0].startTime,
            endTime = course.courseSections[0].endTime {
                let startTimeString = DataFormatter.timeStringFromDate(startTime)
                let endTimeString = DataFormatter.timeStringFromDate(endTime)
                return "\(startTimeString) – \(endTimeString)"
        } else {
            return "TBA"
        }
    }
    
    /**
     Format building string to contain both building name and room number.
     
     - Paramter section: CourseSection object.
     - Returns: Formatted building string.
     */
    static func formatBuildingStringWithSection(section: CourseSection) -> String {
        if let buildingName = section.buildingCode?.uppercaseString,
            roomNumber = section.roomNumber {
                return "\(buildingName) \(roomNumber)"
        } else {
            return "TBA"
        }
    }
}
