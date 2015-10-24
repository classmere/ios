//
//  MapTableViewCell.swift
//  classmere
//
//  Created by Rutger Farry on 10/22/15.
//  Copyright © 2015 Rutger Farry. All rights reserved.
//

import UIKit
import MapKit

class MapTableViewCell: UITableViewCell {
    @IBOutlet weak var mapView: MKMapView!
    
    override func layoutSubviews() {
        mapView.scrollEnabled = false
        mapView.pitchEnabled = false
        mapView.rotateEnabled = false
    }
    
    func navigateToAddress(address: String) {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (placemarks, error) -> Void in
            if let placemark: CLPlacemark = placemarks![0] {
                let mapKitPlacemark = MKPlacemark(placemark: placemark)
                var coordinateRegion = self.mapView.region
                let regionCenter = (mapKitPlacemark.region as! CLCircularRegion).center
                coordinateRegion.center = regionCenter
                coordinateRegion.span.latitudeDelta /= 4096.0
                coordinateRegion.span.longitudeDelta /= 4096.0
                
                self.mapView.setRegion(coordinateRegion, animated: true)
                self.mapView.addAnnotation(mapKitPlacemark)
            }
        }
    }
}
