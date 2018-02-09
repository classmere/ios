import UIKit

extension Course: TableViewCellConvertable {
    static var cellType: UITableViewCell.Type {
        return UITableViewCell.self
    }

    func updateCell(_ cell: UITableViewCell) -> UITableViewCell {
        cell.textLabel?.text = abbr
        cell.detailTextLabel?.text = title
        return cell
    }
}
