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

class MapsViewController: UIViewController , CLLocationManagerDelegate, MKMapViewDelegate,NSURLSessionDataDelegate{
    
    @IBOutlet weak var mapView : MKMapView!;
    
    let locationManager = CLLocationManager();
    var boolLocated : Bool = false;
    
    var session : NSURLSession!
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
        mapView.delegate = self;
    }
    
    override func viewWillAppear(animated: Bool) {
        /*let url = Service.Instance.retriveEventsUrl();
        
        let request : NSMutableURLRequest = NSMutableURLRequest(URL: url);
        
        request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        request.HTTPMethod="GET";
        
        
        
        
        let defaultConfigObject  = NSURLSessionConfiguration.defaultSessionConfiguration();
        
        session = NSURLSession(configuration: defaultConfigObject, delegate: self, delegateQueue: NSOperationQueue.mainQueue())
        session.dataTaskWithRequest(request).resume()*/
        
        var events = getEvents();
        setEventsAnnotateMap(events);
    }
    
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {
        print(data)
        //NSNotificationCenter.defaultCenter().postNotificationName("switchWebView", object:nil)
    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        NSNotificationCenter.defaultCenter().postNotificationName("switchResultView", object:nil)
        self.performSegueWithIdentifier("loginSuccess", sender: nil)
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
        if(view.annotation is PinAnnotation){
            let pinAnnotation = view.annotation as! PinAnnotation;
            if(control == view.leftCalloutAccessoryView){
                print("XXX")
                print(pinAnnotation.title)
            }
        }
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if(annotation is PinAnnotation){
            let pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myPin")
            
            pinAnnotationView.pinTintColor = UIColor.purpleColor()
            pinAnnotationView.draggable = true
            pinAnnotationView.canShowCallout = true
            pinAnnotationView.animatesDrop = true
            
            let infoButton = UIButton()
            infoButton.frame.size.width = 44
            infoButton.frame.size.height = 44
            infoButton.backgroundColor = UIColor.whiteColor()
            infoButton.setImage(Common.getImage((annotation as! PinAnnotation).type), forState: .Normal)
            
            pinAnnotationView.leftCalloutAccessoryView = infoButton
            
            return pinAnnotationView
        }
        return nil;
    }
    
    
    
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        if(view.annotation is PinAnnotation){
            var pinAnnotation = view.annotation as! PinAnnotation;
            
        }
    }
    
    
    
    
    func annotateMap (event : EventEntity){
        let geoCodeArr = event.geoCode.componentsSeparatedByString(",");
        let latitude = Double(geoCodeArr[0]);
        let longitude = Double(geoCodeArr[1]);
        var newCoordinate : CLLocationCoordinate2D = CLLocationCoordinate2D();
        newCoordinate.latitude = latitude!;
        newCoordinate.longitude = longitude!;
        
        let latDelta : CLLocationDegrees = 0.01;
        let longDelta : CLLocationDegrees = 0.01;
        let theSpan : MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta);
        let myLocation : CLLocationCoordinate2D = newCoordinate
        
        
        
        //let theRegion : MKCoordinateRegion = MKCoordinateRegionMake(myLocation, theSpan);
        
        
        
        self.mapView.mapType = MKMapType.Standard
        
        let myHomePin = PinAnnotation();
        myHomePin.setCoordinate(newCoordinate);
        myHomePin.type = event.type as String;
        myHomePin.title = event.title as String;
        
        self.mapView.addAnnotation(myHomePin)
    }

    
    func setEventsAnnotateMap(events :[EventEntity]){
        for item in events{
            annotateMap(item);
        }
    }
    
    func getEvents() -> Array<EventEntity>{
        //let events = [EventEntity];
        let event1 = EventEntity(eventId: 1, holderId: 1, title : "NUS SPORTS", holderDate: NSDate(), geoCode: "1.445215,103.902412", type: "Sports", numberOfJoin: 6, decription: "")
        
        let event2 = EventEntity(eventId: 2, holderId: 2, title : "China Travel" , holderDate: NSDate(), geoCode: "1.405215,103.902412", type: "Travel", numberOfJoin: 8, decription: "")
        
        return [event1, event2]
    }
    
}