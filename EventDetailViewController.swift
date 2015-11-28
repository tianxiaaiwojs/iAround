//
//  EventDetailViewController.swift
//  iAround
//
//  Created by Devendra Desale on 28/11/15.
//  Copyright © 2015 Team3. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {

    
    var event : EventEntity!
    
    @IBOutlet weak var eventTitle: UILabel?
    @IBOutlet weak var eventLocation: UILabel?
    @IBOutlet weak var eventTime: UILabel?
    @IBOutlet weak var eventDescription: UILabel?
    var eventID:String?
    var personID:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func joinEvent(sender: UIButton){
        eventTitle?.text = "something"
        
        // http://52.32.120.191:8000/IEvent/EventsManager/reset/AddAttendance
        
    }

}