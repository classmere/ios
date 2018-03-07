import UIKit

class HomeViewController: UIViewController {

    let store: Store

    var homeView: HomeView!
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

    override func loadView() {
        homeView = HomeView()
        view = homeView
        tableView = homeView.tableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let attributedLabel = UILabel()
        attributedLabel.attributedText = Theme.classmereLogo(withSize: 17)
        navigationItem.titleView = attributedLabel

        navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "",
                                                                style: .plain,
                                                                target: nil,
                                                                action: nil)
        tableViewDataSource = TableViewDataSource(tableView: tableView)
        tableView.delegate = self
        tableView.dataSource = tableViewDataSource
        homeView.searchBar.delegate = self
        view.setNeedsUpdateConstraints()
    }

}

extension HomeViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let course = store.courseSearchResults[indexPath.row]
        store.currentCourse = course
        let courseViewController = CourseViewController(store: store)
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
            tableViewDataSource.rows = []
            return
        }

        store.search(course: searchText) { result in
            switch result {
            case .success(let courses):
                let rows = courses.map { Row<SearchCell>(data: $0) }
                self.tableViewDataSource.rows = rows
            case .failure(let error):
                self.tableViewDataSource.rows = []
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
