import UIKit

final class CourseViewController: UIViewController {
    let store: Store
    var course: Course?
    var buildings = [Building?]()

    let tableView = UITableView()
    var tableViewDataSource: TableViewDataSource!

    init(store: Store) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
        course = store.currentCourse
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
            tableViewDataSource.rows = [Row<CourseDetailsCell>(data: course)] +
                course.sections.map { Row<CourseCell>(data: $0) }
            tableView.delegate = self
            tableView.dataSource = tableViewDataSource

            // Asynchronously fetch course location
            let sectionMeetingTuple: [(Section, [MeetingTime])] = course.sections.map { ($0, $0.meetingTimes.flatMap { $0 } ?? []) }
            let meetingTimes = course.sections.flatMap { $0.meetingTimes }.flatMap { $0 }

            for (section, meetingTimes) in sectionMeetingTuple {
                for meetingTime in
                store.get(buildingAbbr: code) { result in
                    switch result {
                    case .success(let building):
                        self.buildings.append(building)
                    case .failure(let error):
                        self.buildings.append(nil)
                        print(error)
                    }
                    if self.buildings.count == buildingCodes.count {
                        self.tableViewDataSource.rows.insert(Row<MapCell>(data: self.buildings), at: 0)
                    }
                }
            }

        } else {
            navigationController!.popViewController(animated: true)
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
        store.currentSection = course!.sections[indexPath.row - 2]
        let sectionViewController = SectionViewController(store: store)
        self.navigationController?.pushViewController(sectionViewController,
                                                      animated: true)
    }
}
