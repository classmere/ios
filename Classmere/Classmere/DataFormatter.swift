//
//  DataFormatter.swift
//  Classmere
//
//  Created by Brandon Lee on 8/28/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import Foundation

/**
 A model representation of a date formatter.
 */
struct DataFormatter {
    
    /**
     Converts string returned in JSON to a NSDate.
     Offsets time by -7 hours since API returns GMT timezone
     
     - Parameter iso8601String: A string optional with valid date.
     - Returns: A converted NSDate Optional
     
     */
    static func dateFromISO8601String(_ iso8601String: String?) -> Date? {
        if let iso8601String = iso8601String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-DD'T'HH:mm:ssZ"
            let date = dateFormatter.date(from: iso8601String)
            let subtractSevenHours = TimeInterval(60*60*7)
            let offsetDate = date?.addingTimeInterval(subtractSevenHours)
            return offsetDate
        }
        return nil
    }
    
    /**
     Returns a properly formatted date string from an NSDate.
     
     - Parameter date: An NSDate optional with a valid date.
     - Returns: A properly formatted date String.
     */
    static func dateStringFromDate(_ date: Date?) -> String {
        if let date = date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            return dateFormatter.string(from: date)
        } else {
            return ""
        }
    }
    
    /**
     Returns a properly formatted time string from an NSDate.
     
     - Parameter date: An NSDate optional with a valid time.
     - Returns: A properly formatted time String.
     */
    static func timeStringFromDate(_ date: Date?) -> String {
        if let date = date {
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = .short
            return dateFormatter.string(from: date)
        } else {
            return ""
        }
    }
    
    /**
     Returns a user friendly formatted term string
     
     - Parameter term: An unformatted term string (eg. F16)
     - Returns: A formatted term string (eg. Fall 2016)
     */
    static func parseTerm(_ term: String?) -> String {
        if let unparsedTerm = term {
            let season = unparsedTerm.substring(to: unparsedTerm.characters.index(unparsedTerm.startIndex, offsetBy: 2))
            let year = unparsedTerm.substring(from: unparsedTerm.characters.index(unparsedTerm.endIndex, offsetBy: -2))
            var parsedTerm: String = ""
            
            if season.contains("F") {
                parsedTerm += "Fall"
            } else if season.contains("W") {
                parsedTerm += "Winter"
            } else if season.contains("Sp") {
                parsedTerm += "Spring"
            } else if season.contains("Su") {
                parsedTerm += "Summer"
            }
            
            if Int(year) != nil {
                parsedTerm += " 20\(year)"
            }
            
            return parsedTerm
        } else {
            return ""
        }
    }
    
    /**
     Parses a title to remove the subject code and course number
     
     - Parameter title: An unformatted title string
     - Returns: Formatted title string
     */
    static func parseTitle(_ title: String?) -> String {
        if let unparsedTitle = title {
            let titleArray = Array(unparsedTitle.characters)
            var spaceIndexes = [Int]()
            
            for (index, value) in titleArray.enumerated() {
                if value == " " {
                    spaceIndexes.append(index + 1)
                }
            }

            let parsedString: String? = (unparsedTitle as NSString).substring(from: spaceIndexes[1])
            if parsedString != nil {
                return parsedString!
            }
        }
        
        return ""
    }
}
