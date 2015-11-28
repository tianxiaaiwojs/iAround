//
//  EventListViewController.swift
//  iAround
//
//  Created by Devendra Desale on 28/11/15.
//  Copyright © 2015 Team3. All rights reserved.
//


import UIKit

class EventListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSURLSessionDataDelegate{
    
    @IBOutlet weak var eventListTableView: UITableView!

    var events:[EventEntity] = []
    
    let textCellIdentifier = "Cell"

    var eventToPass:EventEntity?
    
    var session : NSURLSession!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        eventListTableView.delegate = self
        eventListTableView.dataSource = self
    }
    
    override func viewWillAppear(animated: Bool) {
        
        events = getEvents();
    }

    func getEvents() -> [EventEntity]{
                
        var urlString = Service.Instance.retriveEventsUrl();
        urlString = String(format: urlString, arguments: ["1.405215","103.902412","2000"])
        
        let url = NSURL(string: urlString)!
        
        let request : NSMutableURLRequest = NSMutableURLRequest(URL: url);
        
        request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        request.HTTPMethod="GET";
        
        var response : NSURLResponse?;
        
        let data : NSData? = ((try! NSURLConnection.sendSynchronousRequest(request, returningResponse: &response)));
        
        
        if(data != nil){
            let dic = JSONHelper.Instance.parseJSONToDictionary(data!)!;
            for item in (dic.valueForKey("RetriveEventsResult") as! Array<Dictionary<String, AnyObject>>)
            {
                events.append(EventEntity.parseJsonToEntity(item) as! EventEntity);
            }
        }
        
        
        /*let defaultConfigObject  = NSURLSessionConfiguration.defaultSessionConfiguration();
        
        session = NSURLSession(configuration: defaultConfigObject, delegate: self, delegateQueue: NSOperationQueue.mainQueue())
        session.dataTaskWithRequest(request).resume();
        let task = session.dataTaskWithRequest(request,completionHandler: {(data, reponse, error) in
            let dic = JSONHelper.Instance.parseJSONToDictionary(data!)!;
            for item in (dic.valueForKey("RetriveEventsResult") as! Array<Dictionary<String, AnyObject>>)
            {
                events.append(EventEntity.parseJsonToEntity(item) as! EventEntity);
            }
            self.eventListTableView.reloadData()
        })
        
        task.resume();*/
        
        let event = EventEntity(eventId : 1, createdById : 1, createdBy : "ANdy", title : "Helo", eventDate : NSDate(), latitude : "1233", longitude : "233", eventType : "Sports", numberOfJoin : 10, eventDesc : "fdlkjdskjf re j fdsf", address : "dfkljaf kjer ler ")

        
        return [event]
    }
    
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {
        /*print(data)
        //NSNotificationCenter.defaultCenter().postNotificationName("switchWebView", object:nil)
        let dic = JSONHelper.Instance.parseJSONToDictionary(data)!;
        for item in (dic.valueForKey("RetriveEventsResult") as! Array<Dictionary<String, AnyObject>>)
        {
            events.append(EventEntity.parseJsonToEntity(item) as! EventEntity);
        }*/
    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        NSNotificationCenter.defaultCenter().postNotificationName("switchResultView", object:nil)
        //self.eventListTableView.reloadData()
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
//        cell.detailTextLabel?.text = "Date: \(event.eventDate)"
        
        return cell
    }

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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        
        if (segue.identifier == "showEvent") {
            if let indexPath = self.eventListTableView.indexPathForSelectedRow{
                let event = events[indexPath.row]
                let controller = segue.destinationViewController as! EventDetailViewController
                controller.event = event
            }
        }
    }
    
    
    @IBAction func addEvent(sender: AnyObject) {
        self.performSegueWithIdentifier("addEvent", sender: nil)
    }
}
