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
        titleLabel.text = course.title?.capitalizedString
        buildingLabel.text = "Kearney Hall 230"
        timeLabel.text = formatCourseTime(course)
    }
    
    func formatCourseTime(course: Course) -> String {
        if let startTime = course.courseSections[0].startTime, endTime = course.courseSections[0].endTime {
            let dateFormatter = NSDateFormatter()
            dateFormatter.timeStyle = .ShortStyle
            let startTimeString = dateFormatter.stringFromDate(startTime)
            let endTimeString = dateFormatter.stringFromDate(endTime)
            return "\(startTimeString) – \(endTimeString)"
        } else {
            return "TBA"
        }
    }
}
