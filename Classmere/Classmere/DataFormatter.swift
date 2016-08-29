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
    static func dateFromISO8601String(iso8601String: String?) -> NSDate? {
        if let iso8601String = iso8601String {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-DD'T'HH:mm:ssZ"
            let date = dateFormatter.dateFromString(iso8601String)
            let subtractSevenHours = NSTimeInterval(60*60*7)
            let offsetDate = date?.dateByAddingTimeInterval(subtractSevenHours)
            return offsetDate
        }
        return nil
    }
    
    /**
     Returns a properly formatted date string from an NSDate.
     
     - Parameter date: An NSDate optional with a valid date.
     - Returns: A properly formatted date String.
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
     Returns a properly formatted time string from an NSDate.
     
     - Parameter date: An NSDate optional with a valid time.
     - Returns: A properly formatted time String.
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
    
    /**
     Returns a user friendly formatted term string
     
     - Parameter term: An unformatted term string (eg. F16)
     - Returns: A formatted term string (eg. Fall 2016)
     */
    static func parseTerm(term: String?) -> String? {
        if let unparsedTerm = term {
            let season = unparsedTerm.substringToIndex(unparsedTerm.startIndex.advancedBy(2))
            let year = unparsedTerm.substringFromIndex(unparsedTerm.endIndex.advancedBy(-2))
            var parsedTerm: String = ""
            
            if season.containsString("F") {
                parsedTerm += "Fall"
            } else if season.containsString("W") {
                parsedTerm += "Winter"
            } else if season.containsString("Sp") {
                parsedTerm += "Spring"
            } else if season.containsString("Su") {
                parsedTerm += "Summer"
            }
            
            if Int(year) != nil {
                parsedTerm += " 20\(year)"
            }
            
            return parsedTerm
        }
        
        return nil
    }
    
    /**
     Returns emoji for a section type
     
     - Parameter type: Type of a section
     - Returns: An emoji string
     */
    static func emojiFromSectionType(type: String?) -> String {
        if let sectionType = type {
            switch sectionType {
            case "Lecture":
                return "💁"
            case "Laboratory":
                return "🔬"
            case "Recitation":
                return "✏️"
            default:
                return "📓"
            }
        }
        
        return "📓"
    }
}