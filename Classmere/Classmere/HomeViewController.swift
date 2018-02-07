import UIKit
import PureLayout
import Alamofire

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UIScrollViewDelegate {

    var homeView: HomeView!
    var didSetupConstraints = false

    var tableView: UITableView!
    var courses = [Course]()
    var currentRequest: Request?

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Classmere"
        self.navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "", style: .plain, target: nil, action: nil)
        homeView = HomeView.newAutoLayout()
        tableView = homeView.tableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchCell.self, forCellReuseIdentifier: "SearchCell")
        homeView.searchBar.delegate = self
        self.view.addSubview(homeView)
        self.view.setNeedsUpdateConstraints()
    }

    // MARK: Custom functions

    func fetchSearchResults(_ query: String, completed: @escaping () -> Void) {
        if let currentRequest = currentRequest {
            currentRequest.cancel()
        }

        currentRequest = APIService.searchCourse(query) { coursesJSON in
            self.courses.removeAll(keepingCapacity: true)
            for (_, courseJSON) in coursesJSON {
                let course = Course(courseJSON: courseJSON)
                self.courses.append(course)
                completed()
            }
        }
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

    // MARK: UITableView Delegate and Datasource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: SearchCell = tableView.dequeueReusableCell(withIdentifier: "SearchCell") as? SearchCell {
            let course = courses[(indexPath as NSIndexPath).row]
            cell.iconLabel.text = EmojiFactory.emojiFromCourseType(course.subjectCode)
            cell.titleLabel.text = course.title
            cell.setNeedsUpdateConstraints()
            cell.updateConstraintsIfNeeded()
            return cell
        } else {
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let courseViewController = CourseViewController(course: courses[indexPath.row])
        self.navigationController?.pushViewController(courseViewController, animated: true)
    }

    // MARK: UISearchBarDelegate

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {

    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        courses.removeAll()
        self.tableView.reloadData()
        homeView.dismissSearchBar(searchBar)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            courses.removeAll()
            self.tableView.reloadData()
        } else {
            fetchSearchResults(searchText) {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: UIScrollViewDelegate

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        tableView.keyboardDismissMode = .onDrag
    }
}
