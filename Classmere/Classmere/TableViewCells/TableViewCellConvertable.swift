import UIKit

protocol TableViewCellConvertable {
    associatedtype Cell: UITableViewCell
    func update(cell: Cell)
}

extension TableViewCellConvertable {
    static var cellIdentifier: String {
        return String(describing: type(of: self))
    }
}
