import UIKit
import PureLayout
import GoogleMaps

enum MapCellPointType {
    case lecture
    case lab
    case recitation
}

struct MapCellPoint {
    let buildingName: String
    let buildingCode: String
    let roomNumber: Int?
    let latitude: Double
    let longitude: Double
    let type: MapCellPointType
}

extension UpdatableCell where Self: MapCell {
    func update(with model: [Building?]) {
        for building in model.flatMap({ $0 }) {
            guard let latitude = building.latitude, let longitude = building.longitude else { return }
            let position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let marker = GMSMarker(position: position)
            marker.title = "\(building.abbr) \(DataFormatter.stringOrEmptyString(forOptional: building.buildingNumber))"
            marker.map = mapView
        }

        selectionStyle = .none
        updateConstraintsIfNeeded()
    }
}

extension MapCell: UpdatableCell {}

class MapCell: UITableViewCell {

    var didSetupConstraints = false

    let mapView = GMSMapView()
//    let schoolZoomSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//    let buildingZoomSpan = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
    let schoolCoordinates = (44.563849, -123.279498)

    var pinLocations = [(Double, Double)]()

    // MARK: - Initialization

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let camera = GMSCameraPosition.camera(withLatitude: schoolCoordinates.0,
                                              longitude: schoolCoordinates.1,
                                              zoom: 13)
        mapView.frame = contentView.frame
        mapView.camera = camera
        contentView.addSubview(mapView)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func navigateTo(latitude: Double, longitude: Double) {
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        marker.title = "Class"
        marker.snippet = "Your class is here"
        marker.map = mapView
    }

    // Open maps app with location.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let pinLocation = pinLocation {
//            let mapItem = MKMapItem(placemark: pinLocation)
//            mapItem.name = "Course Location"
//            mapItem.openInMaps(launchOptions: nil)
//        }
    }

    // MARK: - Layout

    override func updateConstraints() {
        if !didSetupConstraints {
            NSLayoutConstraint.autoSetPriority(UILayoutPriority.required) {
                mapView.autoSetContentCompressionResistancePriority(for: .vertical)
            }

            mapView.autoPinEdgesToSuperviewEdges()

            didSetupConstraints = true
        }

        super.updateConstraints()
    }
}
