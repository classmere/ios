//
//  AbstractClassmereCell.swift
//  classmereApp
//
//  Created by Rutger Farry on 10/26/15.
//  Copyright © 2015 Brandon Lee. All rights reserved.
//

import UIKit

/**
 Basic abstract view representation for tableViewCells.
 */
class AbstractClassmereCell: UITableViewCell {
    override func awakeFromNib() {
        layer.cornerRadius = 10.0
        layer.masksToBounds = true
        backgroundColor = UIColor.clearColor()
        selectionStyle = .None
    }
    
    /**
     Formats the course time to combine start time and end time into one string.
     
     - Parameter course: The course object.
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
        if let buildingName = section.buildingCode,
            roomNumber = section.roomNumber {
                return "\(buildingName) \(roomNumber)"
        } else {
            return "TBA"
        }
    }
}
