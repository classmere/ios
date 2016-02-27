//
//  TodayTableViewCell.swift
//  classmere
//
//  Created by Rutger Farry on 10/22/15.
//  Copyright © 2015 Rutger Farry. All rights reserved.
//

import UIKit

/**
The main page table view cells upon screen load.
 */
class TodayTableViewCell: AbstractClassmereCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var buildingLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    /**
     Fill cell with specific course data.
     
     - Parameter course: The course object.
     - Returns: Nothing.
     */
    func populateWithCourse(course: Course) {
        let section = course.courseSections[0]
        titleLabel.text = course.title?.capitalizedString
        timeLabel.text = TodayTableViewCell.formatCourseTime(course)
        
        buildingLabel.text = TodayTableViewCell.formatBuildingStringWithSection(section)
        super.awakeFromNib()
    }
}
