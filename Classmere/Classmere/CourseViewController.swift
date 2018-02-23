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
        } else {
            navigationController?.popViewController(animated: true)
        }
    }

}

extension CourseViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return course!.sections.count + 2
    }

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
