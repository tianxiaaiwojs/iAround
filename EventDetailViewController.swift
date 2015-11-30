//
//  EventDetailViewController.swift
//  iAround
//
//  Created by 潘安 on 28/11/15.
//  Copyright © 2015 Team3. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {
    
    @IBOutlet weak var eventName: UILabel?
    @IBOutlet weak var eventLocation: UILabel?
    @IBOutlet weak var eventTime: UILabel?
    @IBOutlet weak var eventDescription: UILabel?
    var eventID:String?
    var personID:String?
    var event: EventEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewDidAppear(animated: Bool) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd hh:mm" //format style. Browse online to get a format that fits your needs.
        //var dateString = dateFormatter.stringFromDate(date)
        eventName!.text = self.event!.title
        eventDescription!.text = self.event!.eventDesc
        eventLocation!.text = self.event!.address
        eventTime!.text = dateFormatter.stringFromDate(self.event!.eventDate)
        print(self.event?.eventId)
        self.eventID = String(self.event?.eventId)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func joinEvent(sender: UIButton){
        eventDescription?.text = "You Joined This Event!!!"
        
        let add = "http://52.32.120.191:8000/IEvent/EventsManager/reset/AddAttendance"
        let request = NSMutableURLRequest(URL: NSURL(string: add)!)
        request.HTTPMethod = "POST"
        
        let params = ["EventID": self.eventID!, "PersonID":String(Common.getUserInfo()?.userId!)] as Dictionary<String, String>
        
        print(params)
        
        var err: NSError?
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        var response : NSURLResponse?;
        
        let data : NSData? = ((try! NSURLConnection.sendSynchronousRequest(request, returningResponse: &response)));
        
        let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
        
        print(responseString)
        
        
        /// prepare for the notification
        let now = NSDate() /// suppose now is the target time
        print(now)
        print(event?.eventDate.dateByAddingTimeInterval(-60*15))
        
        let localNotification:UILocalNotification = UILocalNotification()
        localNotification.alertAction = "Testing notifications on iOS8"
        localNotification.alertBody = "Woww it works!!"
        localNotification.fireDate = event?.eventDate.dateByAddingTimeInterval(-60*15)
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancelJoinEvent(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

