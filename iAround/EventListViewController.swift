//
//  EventListViewController.swift
//  iAround
//
//  Created by Devendra Desale on 28/11/15.
//  Copyright © 2015 Team3. All rights reserved.
//


import UIKit

class EventListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var eventListTableView: UITableView!

    var events:[EventEntity] = []
    
    let textCellIdentifier = "Cell"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        eventListTableView.delegate = self
        eventListTableView.dataSource = self
    }
    
    override func viewWillAppear(animated: Bool) {
        /*let url = Service.Instance.retriveEventsUrl();
        
        let request : NSMutableURLRequest = NSMutableURLRequest(URL: url);
        
        request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        request.HTTPMethod="GET";
        
        
        let defaultConfigObject  = NSURLSessionConfiguration.defaultSessionConfiguration();
        
        session = NSURLSession(configuration: defaultConfigObject, delegate: self, delegateQueue: NSOperationQueue.mainQueue())
        session.dataTaskWithRequest(request).resume()*/
        
        events = getEvents();
    }

    func getEvents() -> Array<EventEntity>{
        //let events = [EventEntity];
        let event1 = EventEntity(eventId: 1, holderId: 1, title : "NUS SPORTS", holderDate: NSDate(), geoCode: "1.445215,103.902412", type: "Sports", numberOfJoin: 6, decription: "")
        
        let event2 = EventEntity(eventId: 2, holderId: 2, title : "China Travel" , holderDate: NSDate(), geoCode: "1.405215,103.902412", type: "Travel", numberOfJoin: 8, decription: "")
        
        return [event1, event2]
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as UITableViewCell
        
        let row = indexPath.row
        let event = events[row] ;
        cell.textLabel?.text = event.title
        cell.detailTextLabel?.text = "Date: \(event.holderDate)"
        
        return cell
    }
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let row = indexPath.row
//        
//        let event = events[row];
//        
//        // need to add the call for sending the event to nextpage
//    }
    
    func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        let row = indexPath.row
        
        let event = events[row];
        
        let alertMsg = "\(event.title) \nAddress: \(event.numberOfJoin)"
        
        let alertPopUp:UIAlertController = UIAlertController(title:"Contact Details", message:alertMsg, preferredStyle:UIAlertControllerStyle.Alert)
        
        let cancelAction = UIAlertAction(title: "OK", style: .Cancel) {
            action -> Void in
        }
        
        alertPopUp.addAction(cancelAction)
        self.presentViewController(alertPopUp, animated:true, completion:nil)
        
    }

    
    @IBAction func addEvent(sender: AnyObject) {
        self.performSegueWithIdentifier("addEvent", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showEvent" {
            if let indexPath = self.eventListTableView.indexPathForSelectedRow {
                let event = events[indexPath.row]
                print("Event id selected: \(event.title)")
                //                let object = objects[indexPath.row] as! NSDate
                let controller = segue.destinationViewController as! EventDetailViewController
                //                controller.detailItem = object
                controller.event = event
            }
        }
    }
}
