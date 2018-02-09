import UIKit

protocol TableViewCellConvertable {
    static var cellType: UITableViewCell.Type { get }
    func updateCell(_ cell: UITableViewCell) -> UITableViewCell
}

extension TableViewCellConvertable {
    static var cellIdentifier: String {
        return String(describing: type(of: self))
    }
}
