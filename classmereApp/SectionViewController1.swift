//
//  SectionViewController.swift
//  classmereApp
//
//  Created by Brandon Lee on 11/13/15.
//  Copyright © 2015 Brandon Lee. All rights reserved.
//

import UIKit

class SectionViewController1: UITableViewController {
    
    var detailViewModel: DetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(tableView: UITableView,
        heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            switch indexPath.section {
            case 0,1,2:
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
    
    override func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            switch indexPath.section {
            case 0:
                guard let cell = tableView.dequeueReusableCellWithIdentifier("InfoCell0",
                    forIndexPath: indexPath) as? TodayTableViewCell else {
                        return TodayTableViewCell() //here lies the problem for old irrelevant thing
                }
                let course = detailViewModel.course
                cell.populateWithCourse(course)
                let backgroundColor = UIColor(hue:0.02, saturation:0.64, brightness:0.95, alpha:1)
                cell.contentView.backgroundColor = backgroundColor
                return cell
                
            case 1:
                guard let cell = tableView.dequeueReusableCellWithIdentifier("InfoCell1",
                    forIndexPath: indexPath) as? InfoTableViewCell1 else {
                        return InfoTableViewCell1()
                }
                let course = detailViewModel.course // problem may be in courseViewController
                cell.populateWithCourse(course)
                return cell
                
                // add another case for 2
            case 2:
                guard let cell = tableView.dequeueReusableCellWithIdentifier("InfoCell2",
                    forIndexPath: indexPath) as? InfoTableViewCell1 else {
                        return InfoTableViewCell1()
                }
                let course = detailViewModel.course // problem may be in courseViewController
                cell.populateWithCourse(course)
                return cell
                
            case 3:
                guard let cell = tableView.dequeueReusableCellWithIdentifier("MapCell",
                    forIndexPath: indexPath) as? MapTableViewCell else {
                        return MapTableViewCell()
                }
                if let building = detailViewModel.course.courseSections[0].building,
                    address = building.address {
                        cell.navigateToAddress(address)
                }
                return cell
                
            default:
                print("indexPath.section is: \(indexPath.section)")
                fatalError("Tableview shouldn't contain more than 4 cells")
            }
    }
    
    @IBAction func exitButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
