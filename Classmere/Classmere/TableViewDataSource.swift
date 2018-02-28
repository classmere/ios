import UIKit

protocol RowType {
    var cellClass: AnyClass { get }
    var cellIdentifier: String { get }
    func update(cell: UITableViewCell)
}

struct Row<T>: RowType where T: UpdatableCell, T: UITableViewCell {
    let data: T.Model

    var cellClass: AnyClass {
        return T.self
    }

    var cellIdentifier: String {
        return T.cellIdentifier
    }

    func update(cell: UITableViewCell) {
        if let cell = cell as? T {
            cell.update(with: data)
        }
    }
}

final class TableViewDataSource: NSObject {
    fileprivate weak var tableView: UITableView!

    var rows = [RowType]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    init(rows: [RowType] = [], tableView: UITableView) {
        super.init()
        self.tableView = tableView
        self.rows = rows
    }
}

extension TableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard rows.count > indexPath.row else { return UITableViewCell() }
        let row = rows[indexPath.row]
        tableView.register(row.cellClass, forCellReuseIdentifier: row.cellIdentifier)
        let cell = tableView.dequeueReusableCell(withIdentifier: row.cellIdentifier, for: indexPath)
        row.update(cell: cell)
        return cell
    }
}
