//
//  ViewController.swift
//  iAround
//
//  Created by ZhuBei on 21/11/15.
//  Copyright © 2015 Team3. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController,NSURLSessionDataDelegate, UITextFieldDelegate {
    
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
            if(login((userInfoObject?.loginName)!, password: (userInfoObject?.password)!)){
                self.performSegueWithIdentifier("loginSuccess", sender: nil)
            }
            
        }
        
        textUserName.delegate = self;
        textPassword.delegate = self;
        print(Common.getUserInfo())
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textPassword.resignFirstResponder()
        textUserName.resignFirstResponder()
        return true;
    }
    
    
    
    @IBAction func login(){
        if(login(textUserName.text!, password: textPassword.text!)){
            self.performSegueWithIdentifier("loginSuccess", sender: nil)
        }else{
            let alertPopUp : UIAlertController = UIAlertController(title: "Alert", message: "InCorrect userId or password", preferredStyle: UIAlertControllerStyle.Alert)
            
            let cancelAction = UIAlertAction(title: "Ok", style: .Cancel){ action -> Void in}
            
            alertPopUp.addAction(cancelAction);
            self.presentViewController(alertPopUp, animated: true, completion: nil)
        }
        
    }
    
    func login(loginName : String, password : String) -> Bool{
        textUserName.resignFirstResponder()
        textPassword.resignFirstResponder()
        
        let urlString = Service.Instance.loginUrl();
        
        let url = NSURL(string : urlString)!;
        
        let request : NSMutableURLRequest = NSMutableURLRequest(URL: url);
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.HTTPMethod="POST";
        
        //let user = UserEntity(primaryId: textUserName.text!, password: textPassword.text!)
        
        //let postData : NSData! = user.parseEntityToJson().dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion:true);
        //
        let t = "{\"Name\":\""+loginName+"\",\"Password\":\""+password+"\"}";
        
        let postData : NSData! = t.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion:true);
        request.HTTPBody = postData
        
        //conn = NSURLConnection(request: request, delegate: self)
        
        //conn.start()
        
        
        //let defaultConfigObject  = NSURLSessionConfiguration.defaultSessionConfiguration();
        
        var response : NSURLResponse?;
        
        let data : NSData? = ((try! NSURLConnection.sendSynchronousRequest(request, returningResponse: &response)));
        
        return true;
        
        if(data != nil){
            let dic = JSONHelper.Instance.parseJSONToDictionary(data!)! as! Dictionary<String, AnyObject>;
            
            let user = UserEntity.parseJsonToEntity(dic) as! UserEntity
            var userInfo : UserInfo? = Common.getUserInfo();
            if userInfo == nil{
                userInfo = UserInfo();
            }
            userInfo!.userId = user.personId;
            userInfo!.loginName = user.name;
            userInfo!.password = user.password
            
            Common.setUserInfo(userInfo!);
            return true;
        }
        
        return false;
        /*session = NSURLSession(configuration: defaultConfigObject, delegate: self, delegateQueue: NSOperationQueue.mainQueue())
        session.dataTaskWithRequest(request).resume();*/
        
    }
    
    
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {
        //NSNotificationCenter.defaultCenter().postNotificationName("switchWebView", object:nil)
        /*let dic = JSONHelper.Instance.parseJSONToDictionary(data)! as! Dictionary<String, AnyObject>;
        
        let user = UserEntity.parseJsonToEntity(dic) as! UserEntity
        var userInfo : UserInfo? = Common.getUserInfo();
        if userInfo == nil{
            userInfo = UserInfo();
        }
        userInfo!.userId = user.personId;
        userInfo!.loginName = user.name;
        userInfo!.password = user.password
        
        Common.setUserInfo(userInfo!);*/
    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        NSNotificationCenter.defaultCenter().postNotificationName("switchResultView", object:nil)
        loginSuccessful = true;
        self.performSegueWithIdentifier("loginSuccess", sender: nil)
    }
    
    

}

