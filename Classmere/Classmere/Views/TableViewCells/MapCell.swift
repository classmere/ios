import UIKit
import PureLayout
import GoogleMaps
import MapKit

struct MapCellPoint {
    let buildingName: String?
    let buildingCode: String
    let roomNumber: Int?
    let latitude: Double
    let longitude: Double
    let type: String
}

extension MapCellPoint: Equatable {
    static func == (lhs: MapCellPoint, rhs: MapCellPoint) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

extension MapCellPoint: Hashable {
    var hashValue: Int {
        return latitude.hashValue ^ longitude.hashValue
    }
}

extension UpdatableCell where Self: MapCell {
    func update(with model: [MapCellPoint]) {
        let northmostPoint = model.map { $0.latitude }.max()
        let southmostPoint = model.map { $0.latitude }.min()
        let eastmostPoint = model.map { $0.longitude }.max()
        let westmostPoint = model.map { $0.longitude }.min()

        if let north = northmostPoint, let south = southmostPoint, let east = eastmostPoint, let west = westmostPoint {
            let northEastBound = CLLocationCoordinate2D(latitude: north, longitude: east)
            let southWestBound = CLLocationCoordinate2D(latitude: south, longitude: west)
            let bounds = GMSCoordinateBounds(coordinate: northEastBound, coordinate: southWestBound)
            let insets = UIEdgeInsets(top: 50, left: 10, bottom: 10, right: 10)
            if let camera = mapView.camera(for: bounds, insets: insets) {
                mapView.camera = camera
            } else { print("MapCell error: invalid bounds \(bounds)") }
        }

        for point in model {
            let position = CLLocationCoordinate2D(latitude: point.latitude, longitude: point.longitude)
            let marker = GMSMarker(position: position)

            if let roomNumber = point.roomNumber {
                marker.title = "\(point.type): \(point.buildingCode) \(roomNumber)"
            } else {
                marker.title = "\(point.type): \(point.buildingCode)"
            }
            marker.snippet = "Tap for navigation"

            switch point.type.lowercased() {
            case "laboratory", "lab": marker.icon = GMSMarker.markerImage(with: Theme.Color.green.uicolor)
            case "recitation": marker.icon = GMSMarker.markerImage(with: Theme.Color.blue.uicolor)
            case "studio": marker.icon = GMSMarker.markerImage(with: Theme.Color.brown.uicolor)
            default: marker.icon = GMSMarker.markerImage(with: Theme.Color.red.uicolor)
            }

            marker.map = mapView
        }

        selectionStyle = .none
        updateConstraintsIfNeeded()
    }
}

extension MapCell: UpdatableCell {}

final class MapCell: UITableViewCell {

    let mapView = GMSMapView()
    let schoolCoordinates = (44.563849, -123.279498)

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let camera = GMSCameraPosition.camera(withLatitude: schoolCoordinates.0,
                                              longitude: schoolCoordinates.1,
                                              zoom: 13)
        mapView.setMinZoom(3, maxZoom: 16)
        mapView.frame = contentView.frame
        mapView.settings.rotateGestures = false
        mapView.settings.tiltGestures = false
        mapView.camera = camera
        mapView.delegate = self
        contentView.addSubview(mapView)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Layout

    override func updateConstraints() {
        NSLayoutConstraint.autoSetPriority(UILayoutPriority.required) {
            mapView.autoSetContentCompressionResistancePriority(for: .vertical)
        }
        mapView.autoPinEdgesToSuperviewEdges()

        super.updateConstraints()
    }
}

extension MapCell: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        mapView.selectedMarker = marker
        var animationTargetPoint = mapView.projection.point(for: marker.position)
        animationTargetPoint.y -= 50
        let animationTargetCoordinate = mapView.projection.coordinate(for: animationTargetPoint)
        let cameraUpdate = GMSCameraUpdate.setTarget(animationTargetCoordinate)
        mapView.animate(with: cameraUpdate)
        return true
    }

    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        let lat = marker.position.latitude
        let long = marker.position.longitude
        let zoom = Int(mapView.camera.zoom)
        guard let googleMapsURL = URL(string: "comgooglemaps://?q=\(lat),\(long)&center=\(lat),\(long)&zoom=\(zoom)") else {
            return openInAppleMaps(coordinate: marker.position)
        }

        print("Google maps url: \(googleMapsURL)")
        UIApplication.shared.open(googleMapsURL, options: [:]) { success in
            if !success {
                self.openInAppleMaps(coordinate: marker.position)
            }
        }
    }

    private func openInAppleMaps(coordinate: CLLocationCoordinate2D, name: String? = "Course Location") {
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate))
        mapItem.name = name
        mapItem.openInMaps()
    }

}
