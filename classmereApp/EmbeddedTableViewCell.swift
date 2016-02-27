//
//  EmbeddedTableViewCell.swift
//  classmereApp
//
//  Created by Brandon Lee on 9/7/15.
//  Copyright (c) 2015 Brandon Lee. All rights reserved.
//

import UIKit

/**
 TableViewCell representation for embeddeded cells in the CourseView.
 */
class EmbeddedTableViewCell: UITableViewCell {

    @IBOutlet weak var termLabel: UILabel?
    @IBOutlet weak var startTimeLabel: UILabel?
    @IBOutlet weak var endTimeLabel: UILabel?
    @IBOutlet weak var instructorLabel: UILabel?
}
