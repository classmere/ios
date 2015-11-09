//
//  TodayTableViewCell.swift
//  classmere
//
//  Created by Rutger Farry on 10/22/15.
//  Copyright © 2015 Rutger Farry. All rights reserved.
//

import UIKit

class TodayTableViewCell: AbstractClassmereCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var buildingLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    func populateWithCourse(course: Course) {
        let section = course.courseSections[0]
        titleLabel.text = course.title?.capitalizedString
        timeLabel.text = TodayTableViewCell.formatCourseTime(course)
        buildingLabel.text = TodayTableViewCell.formatBuildingStringWithSection(section)
        super.awakeFromNib()
    }

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

    static func formatBuildingStringWithSection(section: CourseSection) -> String {
        if let buildingName = section.building?.name?.capitalizedString,
            roomNumber = section.roomNumber {
                return "\(buildingName) \(roomNumber)"
        } else {
            return "TBA"
        }
    }
}
