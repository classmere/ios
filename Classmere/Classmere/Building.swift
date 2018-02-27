import Foundation

/**
 A model representation of a building at OSU.
 Reference Docs - https://github.com/classmere/api
 */
struct Building: Codable {
    let abbr: String
    let name: String?
    let address: String?
    let buildingNumber: Int?
    let latitude: Double?
    let longitude: Double?

    init(abbr: String) {
        self.abbr = abbr
        self.name = nil
        self.address = nil
        self.buildingNumber = nil
        self.latitude = nil
        self.longitude = nil
    }
}

extension Building: Hashable {
    var hashValue: Int {
        return abbr.hashValue
    }

    static func == (lhs: Building, rhs: Building) -> Bool {
        return lhs.abbr == rhs.abbr
    }
}
