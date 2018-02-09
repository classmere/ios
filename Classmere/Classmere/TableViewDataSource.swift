import UIKit

class TableViewDataSource: NSObject, UITableViewDataSource {

    fileprivate weak var tableView: UITableView!

    fileprivate var data = [TableViewCellConvertable]()

    init(cellTypes: [TableViewCellConvertable.Type], tableView: UITableView) {
        self.tableView = tableView
        for cellType in cellTypes {
            self.tableView.register(cellType.cellType, forCellReuseIdentifier: cellType.cellIdentifier)
        }
    }

    fileprivate func reuseID(_ cell: AnyClass) -> String {
        return NSStringFromClass(cell.self)
    }

    func updateTableView(_ newData: [TableViewCellConvertable]) {
        DispatchQueue.main.async {
            self.data = newData
            self.tableView.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = data[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: item).cellIdentifier, for: indexPath)
        return item.updateCell(cell)
    }

}
