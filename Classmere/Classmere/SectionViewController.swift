import UIKit

final class SectionViewController: UIViewController {

    let store: Store
    var course: Course?
    var section: Section?

    let tableView = UITableView()
    var tableViewDataSource: TableViewDataSource!

    init(store: Store) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
        course = store.currentCourse
        section = store.currentSection
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

        if let course = course, let section = section {
            title = course.abbr

            tableViewDataSource = TableViewDataSource(tableView: tableView)
            tableViewDataSource.rows = [Row<CourseDetailsCell>(data: course),
                                        Row<SectionCell>(data: section)]
            tableView.delegate = self
            tableView.dataSource = tableViewDataSource

            // Asynchronously fetch course location
            if let buildingAbbr = course.sections.first?.meetingTimes?.first?.buildingCode {
                store.get(buildingAbbr: buildingAbbr) { result in
                    switch result {
                    case .success(let building):
//                        self.tableViewDataSource.rows.insert(Row<MapCell>(data: [nil]), at: 0)
                        print("Got a building: \(building)")
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        } else {
            navigationController!.popViewController(animated: true)
        }
    }
}

    // MARK: UITableView Delegate and Datasource

extension SectionViewController: UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath as NSIndexPath).row < 2 {
            return 150
        } else {
            return 350
        }
    }
}
