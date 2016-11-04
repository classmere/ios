//
//  SectionViewController.swift
//  Classmere
//
//  Created by Brandon Lee on 9/5/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import UIKit

class SectionViewController: UITableViewController {

    var course: Course
    var section: Section
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = course.abbr
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MapCell.self, forCellReuseIdentifier: "MapCell")
        tableView.register(CourseDetailsCell.self, forCellReuseIdentifier: "CourseDetailsCell")
        tableView.register(SectionCell.self, forCellReuseIdentifier: "SectionCell")
        tableView.tableFooterView = UIView()
        self.view.setNeedsUpdateConstraints()
    }
    
    // MARK: - Initialization
    
    init(course: Course, section: Section) {
        self.course = course
        self.section = section
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UITableView Delegate and Datasource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath as NSIndexPath).row < 2 {
            return 150
        } else {
            return 350
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if ((indexPath as NSIndexPath).row == 0) {
            if let cell: MapCell = tableView.dequeueReusableCell(withIdentifier: "MapCell") as? MapCell {
                
                if let buildingAbbr = section.buildingCode {
                    APIService.getBuildingByAbbr(buildingAbbr) { buildingJSON in
                        let building = Building(buildingJSON: buildingJSON)
                        cell.navigateToAddress(building.address)
                    }
                }
                
                cell.setNeedsUpdateConstraints()
                cell.updateConstraintsIfNeeded()
                return cell
            }
        } else if ((indexPath as NSIndexPath).row == 1) {
            if let cell: CourseDetailsCell = tableView.dequeueReusableCell(withIdentifier: "CourseDetailsCell") as? CourseDetailsCell {
                if let title = course.title {
                    cell.titleLabel.text = DataFormatter.parseTitle(title)
                } else {
                    cell.titleLabel.text = ""
                }
                
                if let credits = course.credits {
                    cell.creditsLabel.text = "\(credits) Credit(s)"
                } else {
                    cell.creditsLabel.text = ""
                }
                
                if let description = course.description {
                    cell.descriptionLabel.text = description
                } else {
                    cell.descriptionLabel.text = ""
                }
                
                cell.selectionStyle = .none
                cell.setNeedsUpdateConstraints()
                cell.updateConstraintsIfNeeded()
                
                return cell
            }
        } else {
            if let cell: SectionCell = tableView.dequeueReusableCell(withIdentifier: "SectionCell") as? SectionCell {
                
                if let term = section.term {
                    cell.termLabel.text = DataFormatter.parseTerm(term)
                } else {
                    cell.termLabel.text = "TBA"
                }
                
                if let days = section.days, let startTime = section.startTime, let endTime = section.endTime {
                    cell.dayLabel.text = "\(days) \(DataFormatter.timeStringFromDate(startTime)) - \(DataFormatter.timeStringFromDate(endTime))"
                } else {
                    cell.dayLabel.text = "TBA"
                }
                
                if let instructor = section.instructor {
                    cell.instructorLabel.text = instructor
                } else {
                    cell.instructorLabel.text = "TBA"
                }
                
                if let buildingAbbr = section.buildingCode, let roomNumber = section.roomNumber {
                    cell.locationLabel.text = "\(buildingAbbr) \(roomNumber)"
                } else {
                    cell.locationLabel.text = "TBA"
                }
                
                if let type = section.type {
                    cell.typeLabel.text = type
                } else {
                    cell.typeLabel.text = "TBA"
                }
                
                if let currentlyEnrolled = section.enrollmentCurrent, let enrollmentCapacity = section.enrollmentCapacity {
                    cell.enrolledLabel.text = "\(currentlyEnrolled) student(s) enrolled, \(enrollmentCapacity) spots available"
                } else {
                    cell.enrolledLabel.text = "TBA"
                }
                
                if let startDate = section.startDate, let endDate = section.endDate {
                    cell.dateLabel.text = "\(startDate) - \(endDate)"
                } else {
                    cell.dateLabel.text = "TBA"
                }
                
                if let crn = section.crn {
                    cell.crnLabel.text = "CRN: \(crn)"
                } else {
                    cell.crnLabel.text = "TBA"
                }
                
                cell.selectionStyle = .none
                cell.setNeedsUpdateConstraints()
                cell.updateConstraintsIfNeeded()
                
                return cell
            }
        }
        
        return UITableViewCell()
    }
}
