//
//  DataFormatter.swift
//  classmereApp
//
//  Created by Rutger Farry on 11/5/15.
//  Copyright © 2015 Brandon Lee. All rights reserved.
//

import Foundation

struct DataFormatter {

    /**
        Returns a properly formatted date string from an NSDate

        - Parameter date: An NSDate optional with a valid date
        - Returns: A properly formatted date String
    */
    static func dateStringFromDate(date: NSDate?) -> String {
        if let date = date {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateStyle = .ShortStyle
            return dateFormatter.stringFromDate(date)
        } else {
            return ""
        }
    }

    /**
        Returns a properly formatted time string from an NSDate

        - Parameter date: An NSDate optional with a valid time
        - Returns: A properly formatted time String
     */
    static func timeStringFromDate(date: NSDate?) -> String {
        if let date = date {
            let dateFormatter = NSDateFormatter()
            dateFormatter.timeStyle = .ShortStyle
            return dateFormatter.stringFromDate(date)
        } else {
            return ""
        }
    }
}
