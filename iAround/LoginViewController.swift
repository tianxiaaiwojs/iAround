//
//  ViewController.swift
//  iAround
//
//  Created by ZhuBei on 21/11/15.
//  Copyright © 2015 Team3. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController,NSURLSessionDataDelegate {
    
    @IBOutlet weak var textUserName : UITextField!;
    @IBOutlet weak var textPassword : UITextField!;
    
    //var conn:NSURLConnection!;
    
    var session : NSURLSession!
    
    
    
    var userInfoObject : UserInfo?;
    
    var loginSuccessful : Bool = false;
    
    var data : NSData!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        userInfoObject = Common.getUserInfo();
        if(userInfoObject != nil){
            login((userInfoObject?.loginName)!, password: (userInfoObject?.password)!)
            if(loginSuccessful){
                self.performSegueWithIdentifier("loginSuccess", sender: nil)
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    @IBAction func login(){
        login(textUserName.text!, password: textPassword.text!)
        if(loginSuccessful){
            self.performSegueWithIdentifier("loginSuccess", sender: nil)
        }
    }
    
    func login(loginName : String, password : String) {
        let url = Service.Instance.loginUrl();
        
        let request : NSMutableURLRequest = NSMutableURLRequest(URL: url);
        
        request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        request.HTTPMethod="GET";
        
        //let user = UserEntity(primaryId: textUserName.text!, password: textPassword.text!)
        
        //let postData : NSData! = user.parseEntityToJson().dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion:true);
        //
        let t = "{\"Name\":\""+loginName+"\",\"Password\":\""+password+"\"}";
        
        let postData : NSData! = t.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion:true);
        request.HTTPBody = postData
        
        //conn = NSURLConnection(request: request, delegate: self)
        
        //conn.start()
        
        
        let defaultConfigObject  = NSURLSessionConfiguration.defaultSessionConfiguration();
        
        session = NSURLSession(configuration: defaultConfigObject, delegate: self, delegateQueue: NSOperationQueue.mainQueue())
        session.dataTaskWithRequest(request).resume()
    }
    
    
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {
        print(data)
        //NSNotificationCenter.defaultCenter().postNotificationName("switchWebView", object:nil)
    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        NSNotificationCenter.defaultCenter().postNotificationName("switchResultView", object:nil)
        loginSuccessful = true;
    }
    
    

}

