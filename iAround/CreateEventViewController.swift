//
//  CreateEventViewController.swift
//  iAround
//
//  Created by Aye Mon Kyi Oo on 11/28/15.
//  Copyright © 2015 Team3. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class CreateEventViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, NSURLSessionDataDelegate{
    
    @IBOutlet weak var textFieldTitle: UITextField!
    @IBOutlet weak var textFieldHoldDate: UITextField!
    @IBOutlet weak var textFieldAddress: UITextField!
    @IBOutlet weak var textFieldEventType: UITextField!
    @IBOutlet weak var textFieldNoOfJoin: UITextField!
    @IBOutlet weak var textViewDescription: UITextView!
    @IBOutlet weak var buttonDone: UIButton!
    
    var session : NSURLSession!
    var event: EventEntity!
    var latitude:Double = 0.0
    var longitude:Double = 0.0
    var eventTypes:Array<String>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setTextFieldBorder(textFieldTitle)
        self.setTextFieldBorder(textFieldHoldDate)
        self.setTextFieldBorder(textFieldEventType)
        self.setTextFieldBorder(textFieldAddress)
        self.setTextFieldBorder(textFieldNoOfJoin)
        
        textFieldTitle.delegate = self
        textFieldHoldDate.delegate = self
        textFieldEventType.delegate = self
        textFieldAddress.delegate = self
        textFieldNoOfJoin.delegate = self
        
        eventTypes = [EventType.Sports.rawValue,EventType.Travel.rawValue,EventType.Party.rawValue]
        let pickerViewEventType: UIPickerView = UIPickerView()
        pickerViewEventType.delegate = self
        pickerViewEventType.dataSource = self
        textFieldEventType.inputView = pickerViewEventType
        
        buttonDone.enabled = false
    }
    //set the textField's bottom border
    func setTextFieldBorder(textField: UITextField){
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.lightGrayColor().CGColor
        border.frame = CGRect(x: 0, y: textField.frame.size.height - width, width:  textField.frame.size.width, height: textField
            .frame.size.height)
        border.borderWidth = width
        textField.layer.addSublayer(border)
        textField.layer.masksToBounds = true
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        var nextTage=textField.tag+1;
        var result: Bool = false
        if(textField == textFieldAddress){
            let address: String = textFieldAddress.text!
            result = checkValidAddress();
            if (!result){
                print("invalid address")
                textFieldAddress.text = "";
                nextTage=textField.tag;
            }else{
                print("valid address:\(address)")
                textFieldAddress.text = address
            }
        }
        if(!(textFieldAddress.text!.isEmpty)){
            print("address is not null")
            nextTage=textField.tag+1;
        }
        // Try to find next responder
        let nextResponder=textField.superview?.viewWithTag(nextTage) as UIResponder!
        if (nextResponder != nil){
            // Found next responder, so set it.
            nextResponder?.becomeFirstResponder()
        }
        else{
            // Not found, so remove keyboard
            textField.resignFirstResponder()
        }
        return true;
    }
    func textFieldDidBeginEditing(textField: UITextField) {
        if(textFieldTitle.text!.isEmpty){
        buttonDone.enabled = false
    }else{
        buttonDone.enabled = true
        }
    }
    func textFieldDidEndEditing(textField: UITextField) {
        if(textFieldTitle.text!.isEmpty){
        buttonDone.enabled = false
    }else{
        buttonDone.enabled = true
        }
    }
    func checkValidAddress() -> Bool{
        let address = textFieldAddress.text
        let geocoder = CLGeocoder()
        var result: Bool = false
        geocoder.geocodeAddressString(address!, completionHandler: {(placemarks: [CLPlacemark]?, error: NSError?) -> Void in
            if (error != nil){
                result = false
                self.displayAlert("Location Not Found", message: "Please enter another address")
            }
            else if let placemark = placemarks?[0]{
                self.latitude = placemark.location!.coordinate.latitude;
                self.longitude = placemark.location!.coordinate.longitude;
                result = true
                print(self.longitude);
                print(self.latitude);
                self.textFieldAddress.text = address
            }
            }
        )
        return result
    }
    
    //returns the number of columns to display
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1;
    }
    //return the number of rows for the given component
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return eventTypes!.count
    }
    //set the title to use for a given row in a given component
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return eventTypes![row]
    }
    //set the action to be performed when a row is selected
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textFieldEventType.text = eventTypes![row]
    }
    
    @IBAction func textFieldEditing(sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker();
        datePickerView.datePickerMode = UIDatePickerMode.DateAndTime;
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: Selector("datePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.MediumStyle
        textFieldHoldDate.text = dateFormatter.stringFromDate(sender.date)
    }
    
    @IBAction func saveEvent(sender: AnyObject){
        let title = textFieldTitle.text!
        let holdDate = textFieldHoldDate.text!
        let address = textFieldAddress.text!
        let eventType = textFieldEventType.text!
        let noOfJoin = textFieldNoOfJoin.text!
        let desc = textViewDescription.text!
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.MediumStyle
        
        if (title.isEmpty || holdDate.isEmpty || address.isEmpty || eventType.isEmpty || noOfJoin.isEmpty){
            self.displayAlert("Field is null", message: "Please enter all fields")
        }else{
            //event = EventEntity(eventId: 0,createdById: Int((Common.getUserInfo()?.userId)!), createdBy: (Common.getUserInfo()?.loginName)!, title: title, eventDate: Common.parseStringToDate(holdDate, dateFormatter: dateFormatter), latitude: String(self.latitude), longitude: String(self.longitude), eventType: eventType, numberOfJoin: Int(noOfJoin)!, eventDesc: desc, address: address)
            event = EventEntity(eventId: 0,createdById: 2, createdBy: "Mon", title: title, eventDate: Common.parseStringToDate(holdDate, dateFormatter: dateFormatter), latitude: String(self.latitude), longitude: String(self.longitude), eventType: eventType, numberOfJoin: Int(noOfJoin)!, eventDesc: desc, address: address)
            
            let urlString = Service.Instance.addEventUrl();
            
            let url = NSURL(string : urlString)!;
            
            let request : NSMutableURLRequest = NSMutableURLRequest(URL: url);
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            request.HTTPMethod="POST";
            
            let eventJSONData = event.parseEntityToJson();
            
            let postData : NSData! = eventJSONData.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion:true);
            request.HTTPBody = postData
            
            let defaultConfigObject  = NSURLSessionConfiguration.defaultSessionConfiguration();
            
            session = NSURLSession(configuration: defaultConfigObject, delegate: self, delegateQueue: NSOperationQueue.mainQueue())
            
            session.dataTaskWithRequest(request).resume()
        }
    }
    
    func displayAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert);
        let OKAction = UIAlertAction(title: "OK", style: .Default)
            {(action:UIAlertAction!) in}
        alert.addAction(OKAction)
        self.presentViewController(alert, animated: true, completion: nil);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

