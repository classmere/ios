import UIKit
import PureLayout

class HomeViewController: UIViewController {

    var homeView: HomeView!
    let store: Store
    var didSetupConstraints = false

    var tableView: UITableView!
    var tableViewDataSource: TableViewDataSource!

    // MARK: - Initialization

    init(store: Store) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Classmere"
        navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "",
                                                                style: .plain,
                                                                target: nil,
                                                                action: nil)
        homeView = HomeView.newAutoLayout()
        tableView = homeView.tableView
        tableViewDataSource = TableViewDataSource(tableView: tableView)
        tableView.delegate = self
        tableView.dataSource = tableViewDataSource
        homeView.searchBar.delegate = self
        view.addSubview(homeView)
        view.setNeedsUpdateConstraints()
    }

    // MARK: - Layout

    override func updateViewConstraints() {
        if !didSetupConstraints {
            homeView.autoPin(toTopLayoutGuideOf: self, withInset: 0)
            homeView.autoPin(toBottomLayoutGuideOf: self, withInset: 0)
            homeView.autoPinEdge(toSuperviewEdge: .leading)
            homeView.autoPinEdge(toSuperviewEdge: .trailing)
            didSetupConstraints = true
        }
        super.updateViewConstraints()
    }

}

extension HomeViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let course = store.courseSearchResults[indexPath.row]
        let courseViewController = CourseViewController(course: course)
        navigationController?.pushViewController(courseViewController, animated: true)
    }

}

extension HomeViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        homeView.dismissSearchBar(searchBar)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText.count > 0 else {
            tableViewDataSource.updateTableView([])
            return
        }

        store.search(course: searchText) { result in
            switch result {
            case .success(let courses):
                let rows = courses.map { Row<SearchCell>(data: $0) }
                self.tableViewDataSource.updateTableView(rows)
            case .failure(let error):
                self.tableViewDataSource.updateTableView([])
                print(error)
            }
        }
    }

}

extension HomeViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        tableView.keyboardDismissMode = .onDrag
    }

}
