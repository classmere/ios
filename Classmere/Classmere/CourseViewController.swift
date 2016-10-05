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
        self.navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "", style: .plain, target: nil, action: nil)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MapCell.self, forCellReuseIdentifier: "MapCell")
        tableView.register(CourseDetailsCell.self, forCellReuseIdentifier: "CourseDetailsCell")
        tableView.register(CourseCell.self, forCellReuseIdentifier: "CourseCell")
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return course.sections.count + 2
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath as NSIndexPath).row < 2 {
            return 150
        } else {
            return 110
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if ((indexPath as NSIndexPath).row == 0) {
            if let cell: MapCell = tableView.dequeueReusableCell(withIdentifier: "MapCell") as? MapCell {
                for section in course.sections {
                    if let buildingAbbr = section.buildingCode {
                        APIService.getBuildingByAbbr(buildingAbbr) { buildingJSON in
                            let building = Building(buildingJSON: buildingJSON)
                            cell.navigateToAddress(building.address)
                        }
                    }
                }
                
                cell.isUserInteractionEnabled = false
                cell.selectionStyle = .none
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
                
                cell.isUserInteractionEnabled = false
                cell.selectionStyle = .none
                cell.setNeedsUpdateConstraints()
                cell.updateConstraintsIfNeeded()
                
                return cell
            }
        } else {
            if let cell: CourseCell = tableView.dequeueReusableCell(withIdentifier: "CourseCell") as? CourseCell {
                let cellSection = course.sections[(indexPath as NSIndexPath).row-2]
                
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.pushViewController(SectionViewController(course: course, section: course.sections[(indexPath as NSIndexPath).row-2]), animated: true)
    }
}
