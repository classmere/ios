//
//  SectionViewController.swift
//  classmereApp
//
//  Created by Brandon Lee on 11/13/15.
//  Copyright © 2015 Brandon Lee. All rights reserved.
//

import UIKit

/**
 The view controller which combines all the infotableviewcell views to display all the section details.
 */
class SectionViewController: UITableViewController {
    
    // TODO: Might be better to take in a different view model
    var detailViewModel: DetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Course Details"

        // TODO: Maybe refactor this to be placed somewhere else...
        if let buildingCode = detailViewModel.courseSection?.buildingCode {
            APIService.getLocationByAbbr(buildingCode) { buildingJSON in
                let building = Building(buildingJSON: buildingJSON)
                self.detailViewModel.courseSection?.building = building
                self.tableView.reloadData()
            }
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(tableView: UITableView,
        heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            switch indexPath.section {
            case 0, 1, 2:
                return 122
            case 3:
                return 192
            default:
                // This shouldn't happen
                return 0
            }
    }
    
    override func tableView(tableView: UITableView,
        heightForHeaderInSection section: Int) -> CGFloat {
            return 32
    }
    
    override func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return 1
    }
    
    override func tableView(tableView: UITableView,
        viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView()
            headerView.backgroundColor = UIColor.clearColor()
            return headerView
    }
    
    // TODO: Maybe cut down and make less massive..
    override func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            switch indexPath.section {
            case 0:
                guard let cell0 = tableView.dequeueReusableCellWithIdentifier("InfoCell0",
                    forIndexPath: indexPath) as? InfoTableViewCell0 else {
                        return InfoTableViewCell0()
                }
                let course = detailViewModel.course
                let section = detailViewModel.courseSection
                cell0.populateWithCourse(course, section: section!)
                return cell0
                
            case 1:
                guard let cell1 = tableView.dequeueReusableCellWithIdentifier("InfoCell1",
                    forIndexPath: indexPath) as? InfoTableViewCell1 else {
                        return InfoTableViewCell1()
                }
                let section = detailViewModel.courseSection
                cell1.populateWithCourse(section!)
                return cell1
                
            case 2:
                guard let cell2 = tableView.dequeueReusableCellWithIdentifier("InfoCell2",
                    forIndexPath: indexPath) as? InfoTableViewCell2 else {
                        return InfoTableViewCell2()
                }
                let section = detailViewModel.courseSection
                cell2.populateWithCourse(section!)
                return cell2
                
            case 3:
                guard let cell3 = tableView.dequeueReusableCellWithIdentifier("MapCell",
                    forIndexPath: indexPath) as? MapTableViewCell else {
                        return MapTableViewCell()
                }
                if let building = detailViewModel.courseSection?.building,
                    address = building.address {
                        cell3.navigateToAddress(address)
                }
                return cell3
                
            default:
                fatalError("TableView shouldn't contain more than 4 cells")
            }
    }
    
    @IBAction func exitButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
