import UIKit

extension Course: TableViewCellConvertable {
    func toTableViewCell(_ cell: UITableViewCell) -> UITableViewCell {
        cell.textLabel?.text = abbr
        cell.detailTextLabel?.text = title
        return cell
    }
}
