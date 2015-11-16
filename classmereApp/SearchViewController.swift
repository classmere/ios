//
//  SearchViewController.swift
//  classmereApp
//
//  Created by Nawwaf Almutairi on 10/28/15.
//  Copyright © 2015 Brandon Lee. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    let searchViewModel = SearchViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Set dark keyboard
        searchBar.keyboardAppearance = .Dark
        // Embed searchBar in navBar and change text color
        navigationItem.titleView = searchBar
        if let searchField = searchBar.valueForKey("searchField") as? UITextField {
            searchField.textColor = UIColor.whiteColor()
        }
    }

    // MARK: SearchBar Delegate

    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        if searchText == "" {
            searchViewModel.courses.removeAll()
            tableView.reloadData()
        } else {
            searchViewModel.fetchSearchCourses(searchText) {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: TableView Data Source

    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell",
                forIndexPath: indexPath)
            let course = searchViewModel.courses[indexPath.row]
            cell.textLabel!.text = course.title?.capitalizedString
            cell.detailTextLabel!.text = course.abbr ?? ""
            return cell
    }

    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return searchViewModel.courses.count
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    // MARK: - Table view delegate

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let navigationController = segue.destinationViewController as! UINavigationController
                let controller = navigationController.topViewController as! CourseViewController
                let course = searchViewModel.courses[indexPath.row]
                controller.course = course
            }
        }
    }

    @IBAction func exitButtonWasPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
