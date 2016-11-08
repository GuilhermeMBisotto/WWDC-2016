//
//  MapViewController.swift
//  Guilherme Moresco Bisotto
//
//  Created by Guilherme Moresco Bisotto on 4/22/16.
//  Copyright © 2016 Guilherme Moresco Bisotto. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: BaseViewController, MKMapViewDelegate {

    let MOSCONE_WEST = [37.7830922, -122.4040109]
    let MGM = [36.102576,-115.172442]
    let SANTA_MONICA_PIER = [34.0092986,-118.4990661]
    let HOLLYWOOD_SIGN = [34.134061,-118.321592]
    let INFITE_LOOP = [37.335556,-122.009167]
    let BEVERLY_HILLS = [34.072077,-118.403209]
    
    var segTintColorDefault: UIColor!
    
    @IBOutlet var mapview: MKMapView!
    @IBOutlet var segMapType: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segTintColorDefault = self.segMapType.tintColor
        self.mapview.delegate = self
        
        let spanX = 15.0
        let spanY = 15.0
        var region = MKCoordinateRegion()
        region.center.latitude = SANTA_MONICA_PIER[0]
        region.center.longitude = SANTA_MONICA_PIER[1]
        region.span.latitudeDelta = spanX
        region.span.longitudeDelta = spanY
        self.mapview .setRegion(region, animated: true)
        
        let mosconeWestLocation = CLLocationCoordinate2DMake(MOSCONE_WEST[0], MOSCONE_WEST[1])
        let pinMoscone = CustomAnnotation(coordinate: mosconeWestLocation, annotationID: "SanFrancisco", title: "San Francisco", subtitle: "WWDC 15", detailURL: NSURL(string: "")!)
        
        let mgmLocation = CLLocationCoordinate2DMake(MGM[0], MGM[1])
        let pinMGM = CustomAnnotation(coordinate: mgmLocation, annotationID: "LasVegas", title: "MGM Grand Las Vegas", subtitle: "Meirelles's wedding", detailURL: NSURL(string: "")!)
        
        let santaMonicaLocation = CLLocationCoordinate2DMake(SANTA_MONICA_PIER[0], SANTA_MONICA_PIER[1])
        let pinSantaMonica = CustomAnnotation(coordinate: santaMonicaLocation, annotationID: "SantaMonica", title: "Santa Monica Pier", subtitle: "Just like GTA", detailURL: NSURL(string: "")!)
        
        let beverlyHillsLocation = CLLocationCoordinate2DMake(BEVERLY_HILLS[0], BEVERLY_HILLS[1])
        let pinBeverlyHills = CustomAnnotation(coordinate: beverlyHillsLocation, annotationID: "BeverlyHills", title: "Beverly Hills", subtitle: "Do you have The Watch?", detailURL: NSURL(string: "")!)
        
        let cupertinoLocation = CLLocationCoordinate2DMake(INFITE_LOOP[0], INFITE_LOOP[1])
        let pinCupertino = CustomAnnotation(coordinate: cupertinoLocation, annotationID: "Cupertino", title: "Cupertino Apple Campus", subtitle: "Where the magic happens", detailURL: NSURL(string: "")!)
        
        let hollywoodLocation = CLLocationCoordinate2DMake(HOLLYWOOD_SIGN[0], HOLLYWOOD_SIGN[1])
        let pinHollywood = CustomAnnotation(coordinate: hollywoodLocation, annotationID: "Hollywood", title: "Hollywood", subtitle: "The sign", detailURL: NSURL(string: "")!)
        
        self.mapview.addAnnotations([pinMoscone, pinMGM, pinSantaMonica, pinBeverlyHills, pinCupertino, pinHollywood])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func setMapType(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0:
                self.mapview.mapType = MKMapType.Standard
                self.segMapType.tintColor = segTintColorDefault
            case 1:
                self.mapview.mapType = MKMapType.Satellite
                self.segMapType.tintColor = UIColor.whiteColor()
            default:
                self.mapview.mapType = MKMapType.Hybrid
                self.segMapType.tintColor = UIColor.whiteColor()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "gotoGalery") {
            if let destination = segue.destinationViewController as? GaleryViewController {
                destination.content = sender as! String
            }
        }
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
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let annotation = view.annotation as! CustomAnnotation
        self.performSegueWithIdentifier("gotoGalery", sender: annotation.annotationID)
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

