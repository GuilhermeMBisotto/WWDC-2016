//
//  CustomAnnotation.swift
//  Guilherme Moresco Bisotto
//
//  Created by Guilherme Moresco Bisotto on 4/22/16.
//  Copyright © 2016 Guilherme Moresco Bisotto. All rights reserved.
//

import UIKit
import MapKit

class CustomAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var annotationID: String?
    var title: String?
    var subtitle: String?
    var detailURL: NSURL
    
    init(coordinate: CLLocationCoordinate2D, annotationID: String, title: String, subtitle: String, detailURL: NSURL) {
        self.coordinate = coordinate
        self.annotationID = annotationID
        self.title = title
        self.subtitle = subtitle
        self.detailURL = detailURL
    }
    
    func annotationView() -> MKAnnotationView {
        let view = MKAnnotationView(annotation: self, reuseIdentifier: "CustomAnnotation")
        view.translatesAutoresizingMaskIntoConstraints = true
        view.enabled = true
        view.canShowCallout = true
        view.image = UIImage(named: "pin")
        if !(annotationID == "Home") {
            view.rightCalloutAccessoryView = UIButton(type: UIButtonType.DetailDisclosure)
        }
        view.centerOffset = CGPointMake(0, 0)
        return view
    }
}
