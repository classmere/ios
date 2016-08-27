//
//  CourseViewController.swift
//  Classmere
//
//  Created by Brandon Lee on 8/22/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import UIKit

class CourseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView = UITableView()
    var course: Course
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = course.abbr
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    init(course: Course) {
        self.course = course
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UITableView Delegate and Datasource functions
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return course.sections.count + 2
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        if let cell: SearchCell = tableView.dequeueReusableCellWithIdentifier("SearchCell") as? SearchCell {
//            let course = courses[indexPath.row]
//            cell.titleLabel.text = course.title?.capitalizedString
//            cell.iconLabel.text = "🏫"
//            cell.setNeedsUpdateConstraints()
//            cell.updateConstraintsIfNeeded()
//            return cell
//        } else {
//            return UITableViewCell()
//        }
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        print(tableView.cellForRowAtIndexPath(indexPath)?.description)
//        self.navigationController?.pushViewController(CourseViewController(), animated: true)
    }
}
