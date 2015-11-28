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
    
    var currentLocation : CLLocation!
    
    var event : EventEntity!
    
    //var events:[EventEntity] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if(CLLocationManager.locationServicesEnabled()){
            locationManager.delegate = self;
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.mapView.setUserTrackingMode(MKUserTrackingMode.Follow, animated: true)
            currentLocation = locationManager.location
            locationManager.startUpdatingLocation()
        }
        mapView.delegate = self;
    }
    
    override func viewWillAppear(animated: Bool) {
        
        
        setEventsAnnotateMap(getEvents());
    }
    
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {
        print(data)
        //NSNotificationCenter.defaultCenter().postNotificationName("switchWebView", object:nil)
        /*let dic = JSONHelper.Instance.parseJSONToDictionary(data)!;
        for item in (dic.valueForKey("RetriveEventsResult") as! Array<Dictionary<String, AnyObject>>)
        {
            events.append(EventEntity.parseJsonToEntity(item) as! EventEntity);
        }*/
    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        NSNotificationCenter.defaultCenter().postNotificationName("switchResultView", object:nil)
        //setEventsAnnotateMap(events);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let locationArray = locations as NSArray
        let locationObj = locationArray.lastObject as! CLLocation
        currentLocation = locationObj
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
                event = pinAnnotation.event
                self.performSegueWithIdentifier("showEvent", sender: nil)
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showEvent" {
            var nextScene =  segue.destinationViewController as! EventDetailViewController;
            
            
            // Pass the selected object to the new view controller.
            /*if let indexPath = self.tableView.indexPathForSelectedRow() {
                let selectedVehicle = vehicles[indexPath.row]
                nextScene.currentVehicle = selectedVehicle
            }*/
        }
    }
    
    
    
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        if(view.annotation is PinAnnotation){
            
        }
    }
    
    
    
    
    func annotateMap (event : EventEntity){
        
        let latitude = Double(event.latitude);
        let longitude = Double(event.longitude);
        var newCoordinate : CLLocationCoordinate2D = CLLocationCoordinate2D();
        newCoordinate.latitude = latitude!;
        newCoordinate.longitude = longitude!;
        
        
        //let theRegion : MKCoordinateRegion = MKCoordinateRegionMake(myLocation, theSpan);
        
        
        
        self.mapView.mapType = MKMapType.Standard
        
        let myHomePin = PinAnnotation();
        myHomePin.setCoordinate(newCoordinate);
        myHomePin.type = event.eventType;
        myHomePin.title = event.title as String;
        myHomePin.event = event;
        
        self.mapView.addAnnotation(myHomePin)
    }

    
    func setEventsAnnotateMap(events :[EventEntity]){
        for item in events{
            annotateMap(item);
        }
    }
    
    func getEvents() -> [EventEntity]{
        var events = [EventEntity]();
        
        var urlString = Service.Instance.retriveEventsUrl();
        urlString = String(format: urlString, arguments: [String(currentLocation.coordinate.latitude) ,String(currentLocation.coordinate.longitude),"2000"])
        
        let url = NSURL(string: urlString)!
        
        let request : NSMutableURLRequest = NSMutableURLRequest(URL: url);
        
        request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        request.HTTPMethod="GET";
        
        
        
        
        //let defaultConfigObject  = NSURLSessionConfiguration.defaultSessionConfiguration();
        var response : NSURLResponse?;
        
        let data : NSData? = ((try! NSURLConnection.sendSynchronousRequest(request, returningResponse: &response)));
        
        if(data != nil){
            let dic = JSONHelper.Instance.parseJSONToDictionary(data!)!;
            for item in (dic.valueForKey("RetriveEventsResult") as! Array<Dictionary<String, AnyObject>>)
            {
                events.append(EventEntity.parseJsonToEntity(item) as! EventEntity);
            }
        }
       
        
        return events;
        //session = NSURLSession(configuration: defaultConfigObject, delegate: self, delegateQueue: NSOperationQueue.mainQueue())
        //session.dataTaskWithRequest(request).resume();
        /*let task = session.dataTaskWithRequest(request,completionHandler: {(data, reponse, error) in
            let dic = JSONHelper.Instance.parseJSONToDictionary(data!)!;
            for item in (dic.valueForKey("RetriveEventsResult") as! Array<Dictionary<String, AnyObject>>)
            {
                events.append(EventEntity.parseJsonToEntity(item) as! EventEntity);
            }
        })
        
        task.resume();*/
    }
    
}