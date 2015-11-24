//
//  MapsViewController.swift
//  iAround
//
//  Created by ZhuBei on 21/11/15.
//  Copyright © 2015 Team3. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapsViewController: UIViewController , CLLocationManagerDelegate, MKMapViewDelegate{
    
    @IBOutlet weak var mapView : MKMapView!;
    
    let locationManager = CLLocationManager();
    var boolLocated : Bool = false;
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if(CLLocationManager.locationServicesEnabled()){
            locationManager.delegate = self;
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.mapView.setUserTrackingMode(MKUserTrackingMode.Follow, animated: true)
            locationManager.startUpdatingLocation()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let locationArray = locations as NSArray
        let locationObj = locationArray.lastObject as! CLLocation
        let coord = locationObj.coordinate
        
        print(coord.latitude)
        print(coord.longitude)

        //annotateMap(manager.location!.coordinate)
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myPin")
        
        pinAnnotationView.pinTintColor = UIColor.purpleColor()
        pinAnnotationView.draggable = true
        pinAnnotationView.canShowCallout = true
        pinAnnotationView.animatesDrop = true
        return pinAnnotationView;
    }
    
    
    
    
    func annotateMap (newCoordinate : CLLocationCoordinate2D){
        let latDelta : CLLocationDegrees = 0.01;
        let longDelta : CLLocationDegrees = 0.01;
        let theSpan : MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta);
        let myLocation : CLLocationCoordinate2D = newCoordinate
        
        let theRegion : MKCoordinateRegion = MKCoordinateRegionMake(myLocation, theSpan);
        
        if(!boolLocated){
            self.mapView.setRegion(theRegion, animated: true)
            boolLocated = true;
        }
        
        self.mapView.mapType = MKMapType.Standard
        
        let myHomePin = MKPointAnnotation();
        myHomePin.coordinate = newCoordinate;
        self.mapView.addAnnotation(myHomePin)
    }
    
    func setEventsAnnotateMap(events :[EventEntity]){
        
    }
    
}