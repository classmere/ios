import UIKit

enum Theme {
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
