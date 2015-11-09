//
//  MapTableViewCell.swift
//  classmere
//
//  Created by Rutger Farry on 10/22/15.
//  Copyright © 2015 Rutger Farry. All rights reserved.
//

import UIKit
import MapKit

class MapTableViewCell: AbstractClassmereCell {
    @IBOutlet weak var mapView: MKMapView!

    let schoolZoomSpan = MKCoordinateSpan(
        latitudeDelta: 0.02,
        longitudeDelta: 0.02)
    let buildingZoomSpan = MKCoordinateSpan(
        latitudeDelta: 0.005,
        longitudeDelta: 0.005)

    override func awakeFromNib() {
        let schoolCoordinates = CLLocationCoordinate2D(
            latitude: 44.563849,
            longitude: -123.279498)
        let schoolCoordinateRegion = MKCoordinateRegion(
            center: schoolCoordinates,
            span: schoolZoomSpan)
        mapView.setRegion(schoolCoordinateRegion, animated: false)

        super.awakeFromNib()
    }

    func navigateToAddress(address: String) {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { placemarks, error in
            if let placemark: CLPlacemark = placemarks![0],
                placemarkRegion = placemark.region as? CLCircularRegion {
                let mapKitPlacemark = MKPlacemark(placemark: placemark)
                var currentCoordinateRegion = self.mapView.region
                currentCoordinateRegion.center = placemarkRegion.center
                currentCoordinateRegion.span = self.buildingZoomSpan

                self.mapView.setRegion(currentCoordinateRegion, animated: true)
                self.mapView.addAnnotation(mapKitPlacemark)
            }
        }
    }
}
