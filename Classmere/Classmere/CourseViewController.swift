//
//  CourseViewController.swift
//  Classmere
//
//  Created by Brandon Lee on 8/22/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import UIKit

class CourseViewController: UITableViewController {
    
    var course: Course
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = course.abbr
        self.navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "", style: .Plain, target: nil, action: nil)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(MapCell.self, forCellReuseIdentifier: "MapCell")
        tableView.registerClass(CourseDetailsCell.self, forCellReuseIdentifier: "CourseDetailsCell")
        tableView.registerClass(CourseCell.self, forCellReuseIdentifier: "CourseCell")
        tableView.tableFooterView = UIView()
        self.view.setNeedsUpdateConstraints()
    }
    
    // MARK: - Initialization
    
    init(course: Course) {
        self.course = course
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
        return course.sections.count + 2
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row < 2 {
            return 150
        } else {
            return 110
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            if let cell: MapCell = tableView.dequeueReusableCellWithIdentifier("MapCell") as? MapCell {
                for section in course.sections {
                    if let buildingAbbr = section.buildingCode {
                        APIService.getBuildingByAbbr(buildingAbbr) { buildingJSON in
                            let building = Building(buildingJSON: buildingJSON)
                            cell.navigateToAddress(building.address)
                        }
                    }
                }
                
                cell.userInteractionEnabled = false
                cell.selectionStyle = .None
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
            if let cell: CourseCell = tableView.dequeueReusableCellWithIdentifier("CourseCell") as? CourseCell {
                let cellSection = course.sections[indexPath.row-2]
                
                cell.termLabel.text = DataFormatter.parseTerm(cellSection.term)
                cell.iconLabel.text = EmojiFactory.emojiFromSectionType(cellSection.type)
                
                if let days = cellSection.days {
                    cell.timeLabel.text = "\(days) \(DataFormatter.timeStringFromDate(cellSection.startTime)) - \(DataFormatter.timeStringFromDate(cellSection.endTime))"
                } else {
                    cell.timeLabel.text = "TBA"
                }
                
                if let instructor = cellSection.instructor {
                    if instructor != "" {
                        cell.instructorLabel.text = instructor
                    } else {
                        cell.instructorLabel.text = "TBA"
                    }
                } else {
                    cell.instructorLabel.text = "TBA"
                }
                
                if let building = cellSection.buildingCode, let room = cellSection.roomNumber {
                    cell.locationLabel.text = "\(building) \(room)"
                } else {
                    cell.locationLabel.text = "TBA"
                }
                
                if let type = cellSection.type {
                    cell.typeLabel.text = type
                } else {
                    cell.typeLabel.text = "TBA"
                }
                
                cell.setNeedsUpdateConstraints()
                cell.updateConstraintsIfNeeded()
                
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.navigationController?.pushViewController(SectionViewController(course: course, section: course.sections[indexPath.row-2]), animated: true)
    }
}
