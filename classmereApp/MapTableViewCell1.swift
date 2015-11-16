//
//  MapTableViewCell1.swift
//  classmereApp
//
//  Created by Brandon Lee on 11/14/15.
//  Copyright © 2015 Brandon Lee. All rights reserved.
//

import UIKit
import MapKit

class MapTableViewCell1: AbstractClassmereCell {
    
    @IBOutlet weak var mapView: MKMapView!

    let mapItem = MKMapItem()
    
    let schoolZoomSpan = MKCoordinateSpan(
        latitudeDelta: 0.02,
        longitudeDelta: 0.02)
    let buildingZoomSpan = MKCoordinateSpan(
        latitudeDelta: 0.005,
        longitudeDelta: 0.005)
    
    var pinLocation: MKPlacemark?
    
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
                
                self.pinLocation = mapKitPlacemark
            }
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let pinLocation = pinLocation {
            let mapItem = MKMapItem(placemark: pinLocation)
            mapItem.name = "Course Location"
            mapItem.openInMapsWithLaunchOptions(nil)
        }
    }
}
