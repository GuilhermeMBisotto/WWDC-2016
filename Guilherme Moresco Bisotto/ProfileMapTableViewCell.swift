//
//  ProfileMapTableViewCell.swift
//  Guilherme Moresco Bisotto
//
//  Created by Guilherme Moresco Bisotto on 4/25/16.
//  Copyright © 2016 Guilherme Moresco Bisotto. All rights reserved.
//

import UIKit
import MapKit

class ProfileMapTableViewCell: UITableViewCell, MKMapViewDelegate {

    var long: NSNumber!
    var lat: NSNumber!
    var HOME = [-29.9221863, -51.04918139999995]
    
    @IBOutlet var labelLocation: UILabel!
    @IBOutlet var map: MKMapView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.map.delegate = self
        
        let spanX = 10.0
        let spanY = 10.0
        var region = MKCoordinateRegion()
        region.center.latitude = HOME[0]
        region.center.longitude = HOME[1]
        region.span.latitudeDelta = spanX
        region.span.longitudeDelta = spanY
        self.map.setRegion(region, animated: true)
        
        let homeLocation = CLLocationCoordinate2DMake(HOME[0], HOME[1])
        let pinHome = CustomAnnotation(coordinate: homeLocation, annotationID: "Home", title: "My Home", subtitle: "Far Far Away", detailURL: NSURL(string: "")!)
        
        self.map.addAnnotation(pinHome)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if (annotation is MKUserLocation) {
            return nil
        }
        
        if (annotation.isKindOfClass(CustomAnnotation)) {
            let customAnnotation = annotation as? CustomAnnotation
            mapView.translatesAutoresizingMaskIntoConstraints = false
            var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier("CustomAnnotation") as MKAnnotationView!
            
            if (annotationView == nil) {
                annotationView = customAnnotation?.annotationView()
            } else {
                annotationView.annotation = annotation;
            }
            
            addBounceAnimationToView(annotationView)
            return annotationView
        } else {
            return nil
        }
    }
    
    func addBounceAnimationToView(view: UIView) {
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale") as CAKeyframeAnimation
        bounceAnimation.values = [ 0.05, 1.1, 0.9, 1]
        
        let timingFunctions = NSMutableArray(capacity: bounceAnimation.values!.count)
        
        for _ in 0 ..< bounceAnimation.values!.count {
            timingFunctions.addObject(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut))
        }
        bounceAnimation.timingFunctions = timingFunctions as NSArray as? [CAMediaTimingFunction]
        bounceAnimation.removedOnCompletion = false
        
        view.layer.addAnimation(bounceAnimation, forKey: "bounce")
    }

}
