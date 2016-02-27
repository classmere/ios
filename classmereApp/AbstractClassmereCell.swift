//
//  AbstractClassmereCell.swift
//  classmereApp
//
//  Created by Rutger Farry on 10/26/15.
//  Copyright © 2015 Brandon Lee. All rights reserved.
//

import UIKit

/**
 Basic abstract view representation for tableViewCells.
 */
class AbstractClassmereCell: UITableViewCell {
    override func awakeFromNib() {
        layer.cornerRadius = 10.0
        layer.masksToBounds = true
        backgroundColor = UIColor.clearColor()
        selectionStyle = .None
    }
}
