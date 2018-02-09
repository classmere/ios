import UIKit

class TableViewDataSource: NSObject, UITableViewDataSource {

    fileprivate let tableView: UITableView

    fileprivate let reuseID = " "

    fileprivate var data = [TableViewCellConvertable]()

    init(cellType: AnyClass?, tableView: UITableView) {
        self.tableView = tableView
        self.tableView.register(cellType.self, forCellReuseIdentifier: reuseID)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath)
        return data[indexPath.row].toTableViewCell(cell)
    }

}
