import UIKit
import PureLayout

class CourseViewController: UIViewController {

    let store: Store
    var course: Course?
    var buildings = [Building]()

    let tableView = UITableView()
    var tableViewDataSource: TableViewDataSource!

    init(store: Store) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
        self.course = store.currentCourse
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        tableView.frame = UIScreen.main.bounds
        view = tableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let course = course {
            title = course.abbr
            navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "",
                                                                    style: .plain,
                                                                    target: nil,
                                                                    action: nil)

            tableViewDataSource = TableViewDataSource(tableView: tableView)
            tableViewDataSource.updateTableView([Row<CourseDetailsCell>(data: course)]
                                                + course.sections.map { Row<CourseCell>(data: $0) })
            tableView.delegate = self
            tableView.dataSource = tableViewDataSource

            // Asynchronously fetch course location
            // TODO: Show all course locations on map instead of just first occurence
            if let buildingAbbr = course.sections.first?.meetingTimes?.first?.buildingCode {
                store.get(buildingAbbr: buildingAbbr) { result in
                    switch result {
                    case .success(let building):
                        self.tableViewDataSource.rows.insert(Row<MapCell>(data: building), at: 0)
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        } else {
            navigationController?.popViewController(animated: true)
        }
    }

}

extension CourseViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath as NSIndexPath).row < 2 {
            return 150
        } else {
            return 110
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let sectionViewController = SectionViewController(course: course!,
                                                          section: course!.sections[(indexPath as NSIndexPath).row-2])
        self.navigationController?.pushViewController(sectionViewController,
                                                      animated: true)
    }

}
