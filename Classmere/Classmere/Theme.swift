import UIKit

enum Theme {

    enum Color: String {
        case blue = "2850ad"
        case orange = "ff6319"
        case limeGreen = "6cbe45"
        case lightGrey = "a7a9ac"
        case brown = "996633"
        case yellow = "fccc0a"
        case red = "ee352e"
        case green = "00933c"
        case purple = "b933ad"
        case grey = "808183"

        var uicolor: UIColor {
            return UIColor(hexString: self.rawValue)!
        }
    }

    /// Returns an NSAttributedString of the classmere logo with the requested `size`
    /// - parameter size: A CGFloat indicating the requested text size of the string
    static func classmereLogo(withSize size: CGFloat) -> NSAttributedString {
        let classmere = NSMutableAttributedString()
        classmere.append(NSAttributedString(string: "class", attributes: [
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: size)]))
        classmere.append(NSAttributedString(string: "mere", attributes: [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: size)]))
        return classmere
    }
}
