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
        tableView.registerClass(MapCell.self, forCellReuseIdentifier: "MapCell")
        tableView.registerClass(CourseDetailsCell.self, forCellReuseIdentifier: "CourseDetailsCell")
        tableView.registerClass(SectionCell.self, forCellReuseIdentifier: "SectionCell")
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
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row < 2 {
            return 150
        } else {
            return 350
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            if let cell: MapCell = tableView.dequeueReusableCellWithIdentifier("MapCell") as? MapCell {
                
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
        } else if (indexPath.row == 1) {
            if let cell: CourseDetailsCell = tableView.dequeueReusableCellWithIdentifier("CourseDetailsCell") as? CourseDetailsCell {
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
                
                cell.selectionStyle = .None
                cell.setNeedsUpdateConstraints()
                cell.updateConstraintsIfNeeded()
                
                return cell
            }
        } else {
            if let cell: SectionCell = tableView.dequeueReusableCellWithIdentifier("SectionCell") as? SectionCell {
                
                if let term = section.term {
                    cell.termLabel.text = DataFormatter.parseTerm(term)
                } else {
                    cell.termLabel.text = "TBA"
                }
                
                if let days = section.days, startTime = section.startTime, endTime = section.endTime {
                    cell.dayLabel.text = "\(days) \(DataFormatter.timeStringFromDate(startTime)) - \(DataFormatter.timeStringFromDate(endTime))"
                } else {
                    cell.dayLabel.text = "TBA"
                }
                
                if let instructor = section.instructor {
                    cell.instructorLabel.text = instructor
                } else {
                    cell.instructorLabel.text = "TBA"
                }
                
                if let buildingAbbr = section.buildingCode, roomNumber = section.roomNumber {
                    cell.locationLabel.text = "\(buildingAbbr) \(roomNumber)"
                } else {
                    cell.locationLabel.text = "TBA"
                }
                
                if let type = section.type {
                    cell.typeLabel.text = type
                } else {
                    cell.typeLabel.text = "TBA"
                }
                
                if let currentlyEnrolled = section.enrollmentCurrent, enrollmentCapacity = section.enrollmentCapacity {
                    cell.enrolledLabel.text = "\(currentlyEnrolled) student(s) enrolled, \(enrollmentCapacity) spots available"
                } else {
                    cell.enrolledLabel.text = "TBA"
                }
                
                if let startDate = section.startDate, endDate = section.endDate {
                    cell.dateLabel.text = "\(startDate) - \(endDate)"
                } else {
                    cell.dateLabel.text = "TBA"
                }
                
                if let crn = section.crn {
                    cell.crnLabel.text = "CRN: \(crn)"
                } else {
                    cell.crnLabel.text = "TBA"
                }
                
                cell.selectionStyle = .None
                cell.setNeedsUpdateConstraints()
                cell.updateConstraintsIfNeeded()
                
                return cell
            }
        }
        
        return UITableViewCell()
    }
}
