//
//  TestTableViewController.swift
//  classmereApp
//
//  Created by Brandon Lee on 9/5/15.
//  Copyright (c) 2015 Brandon Lee. All rights reserved.
//

import UIKit

class TestTableViewController: UITableViewController {

    //let fruits = ["Apples", "Bananas", "Oranges", "Pineapples", "Watermelons", "Strawberries", "Raspberries", "Grapes", "Pomegranates", "Peaches", "Cherries", "Dates"]
    
    var fruits = [Course]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APIService.getAllCourses() { (data) -> Void in
            for courseIndex in data {
                var course: Course = Course(courseJSON: courseIndex.1)
                println("The courseIndex: " + courseIndex.0)
                self.fruits.append(course)
                println("allCourses Length")
                println(self.fruits.count)
            }
            self.tableView.reloadData()
            
            // TODO: Learn about this
            //self.tableView.delegate = self
            //self.tableView.dataSource = self
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println("in numberOfRowsInSection")
        println(fruits.count)
        return fruits.count
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        println("in cellForRowatIndexPath")
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        let fruit = fruits[indexPath.row]
        cell.textLabel!.text = fruit.abbr
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
}
