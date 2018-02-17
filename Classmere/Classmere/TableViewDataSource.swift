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
    fileprivate var rows = [RowType]()

    init(rows: [RowType] = [], tableView: UITableView) {
        super.init()
        self.tableView = tableView
        registerRows()
    }

    fileprivate func registerRows() {
        for row in rows {
            tableView.register(row.cellClass, forCellReuseIdentifier: row.cellIdentifier)
        }
    }

    func updateTableView(_ newData: [RowType]) {
        DispatchQueue.main.async {
            self.rows = newData
            self.registerRows()
            self.tableView.reloadData()
        }
    }
}

extension TableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = rows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: row.cellIdentifier, for: indexPath)
        row.update(cell: cell)
        return cell
    }
}
