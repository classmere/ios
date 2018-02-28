import Foundation

/**
 Returns the String representation of an optional or an empty String

 - Parameter optional: Any Optional
 - Returns: A String representation of the Object if not null, otherwise an empty String
 */
func optionalDescriptionOrEmptyString(_ optional: Any?) -> String {
    if let unwrapped = optional { return String(describing: unwrapped) }
    return ""
}

/**
 A model representation of a date formatter.
 */
struct DataFormatter {

    /**
     Returns a user friendly formatted term string
     
     - Parameter term: An unformatted term string (eg. F16)
     - Returns: A formatted term string (eg. Fall 2016)
     */
    static func parseTerm(_ term: String?) -> String {
        if let unparsedTerm = term, unparsedTerm.count > 2 {
            let season = unparsedTerm[..<unparsedTerm.index(unparsedTerm.startIndex, offsetBy: 2)]
            let year = unparsedTerm[unparsedTerm.index(unparsedTerm.endIndex, offsetBy: -2)...]
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
            var spaceIndexes = [Int]()

            for (index, value) in unparsedTitle.enumerated() where value == " " {
                spaceIndexes.append(index + 1)
            }

            let parsedString: String? = (unparsedTitle as NSString).substring(from: spaceIndexes[1])
            if parsedString != nil {
                return parsedString!
            }
        }

        return ""
    }
}
