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

        if let course = course {
            title = course.abbr

            tableViewDataSource = TableViewDataSource(tableView: tableView)
            tableViewDataSource.rows = [Row<MapCell>(data: [])] +
                [Row<CourseDetailsCell>(data: course)] +
                course.sections.map { Row<CourseCell>(data: $0) }
            tableView.delegate = self
            tableView.dataSource = tableViewDataSource

            fetchBuildings(forCourse: course)
        } else {
            navigationController!.popViewController(animated: true)
        }
    }

    /// Gets all buildings for all meetingTimes for all sections and updates tableView with locations
    func fetchBuildings(forCourse course: Course) {
        var mapCellPoints = Set<MapCellPoint>()
        var inFlightRequests = 0

        for section in course.sections {
            let meetingTimes = section.meetingTimes?.filter { $0.buildingCode != nil } ?? []

            for meetingTime in meetingTimes {
                guard let code = meetingTime.buildingCode else { return }
                inFlightRequests += 1
                store.get(buildingAbbr: code) { result in
                    inFlightRequests -= 1
                    switch result {
                    case .success(let building):
                        guard let latitude = building.latitude, let longitude = building.longitude else { return }
                        mapCellPoints.insert(MapCellPoint(buildingName: building.name,
                                                          buildingCode: building.abbr,
                                                          roomNumber: meetingTime.roomNumber,
                                                          latitude: latitude,
                                                          longitude: longitude,
                                                          type: section.type))
                    case .failure(let error):
                        print("fetchBuildings() error: \(error)")
                    }
                    if inFlightRequests == 0 {
                        self.tableViewDataSource.rows = [Row<MapCell>(data: Array(mapCellPoints))] +
                            [Row<CourseDetailsCell>(data: course)] +
                            course.sections.map { Row<CourseCell>(data: $0) }
                    }
                }
            }

        }
    }
}

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
