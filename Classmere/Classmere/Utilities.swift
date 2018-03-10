import Foundation

enum UtilitiesError: Error {
    case sortTerms(String)
}

/**
 A model representation of a date formatter.
 */
struct Utilities {

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

    /**
     Returns the String representation of an optional or an empty String

     - Parameter optional: Any Optional
     - Returns: A String representation of the Object if not null, otherwise an empty String
     */
    static func optionalDescriptionOrEmptyString(_ optional: Any?) -> String {
        if let unwrapped = optional { return String(describing: unwrapped) }
        return ""
    }

    /**
     Sorts an array of strings containing term information, e.g. "W18"
     */
    static func sortTerms(el1: String, el2: String) throws -> Bool {
        guard el1.count > 2 && el2.count > 2 else {
            throw  UtilitiesError.sortTerms("Array contains < 3 elements")
        }
        guard let el1Year = Int(el1[el1.index(el1.endIndex, offsetBy: -2)...]) else {
            throw UtilitiesError.sortTerms("Could not parse year from string: \(el1)")
        }
        guard let el2Year = Int(el2[el2.index(el2.endIndex, offsetBy: -2)...]) else {
            throw UtilitiesError.sortTerms("Could not parse year from string: \(el2)")
        }
        let el1Term = String(el1[..<el1.index(el1.endIndex, offsetBy: -2)])
        let el2Term = String(el2[..<el2.index(el2.endIndex, offsetBy: -2)])

        if el1Year > el2Year { return false }
        if el1Year < el2Year { return true }

        let termRawValues = [
            "W": 0,
            "Sp": 1,
            "Su": 2,
            "F": 3,
            "T": 4
        ]

        if let el1RawValue = termRawValues[el1Term], let el2RawValue = termRawValues[el2Term] {
            return el1RawValue < el2RawValue
        }
        throw UtilitiesError.sortTerms("Array contains invalid terms: \(el1Term), \(el2Term)")
    }
}
