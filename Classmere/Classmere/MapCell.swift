//
//  MapCell.swift
//  Classmere
//
//  Created by Brandon Lee on 9/4/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import UIKit
import PureLayout
import MapKit

class MapCell: UITableViewCell {
    
    var didSetupConstraints = false
    
    let mapView: MKMapView = MKMapView.newAutoLayoutView()
    let schoolZoomSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    let buildingZoomSpan = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
    let schoolCoordinates = CLLocationCoordinate2D(latitude: 44.563849, longitude: -123.279498)
    
    var pinLocation: MKPlacemark?
    
    // MARK: - Initialization
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    // MARK: - Setup
    
    func setupViews() {
        let schoolCoordinateRegion = MKCoordinateRegion(center: schoolCoordinates, span: schoolZoomSpan)
        mapView.setRegion(schoolCoordinateRegion, animated: false)
        
        contentView.addSubview(mapView)
    }
    
    /**
     Set up map region and pin.
     
     - Parameter address: The address of the building.
     */
    func navigateToAddress(address: String?) {
        if let address = address {
            let geoCoder = CLGeocoder()
            geoCoder.geocodeAddressString(address) { placemarks, error in
                if let placemark: CLPlacemark = placemarks![0], placemarkRegion = placemark.region as? CLCircularRegion {
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
    }
    
    // Open maps app with location.
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let pinLocation = pinLocation {
            let mapItem = MKMapItem(placemark: pinLocation)
            mapItem.name = "Course Location"
            mapItem.openInMapsWithLaunchOptions(nil)
        }
    }
    
    // MARK: - Layout
    
    override func updateConstraints() {
        if !didSetupConstraints {
            NSLayoutConstraint.autoSetPriority(UILayoutPriorityRequired) {
                self.mapView.autoSetContentCompressionResistancePriorityForAxis(.Vertical)
            }
            
            mapView.autoPinEdgesToSuperviewEdges()
            
            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
}
