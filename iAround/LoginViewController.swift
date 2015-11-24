//
//  ViewController.swift
//  iAround
//
//  Created by ZhuBei on 21/11/15.
//  Copyright © 2015 Team3. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var textUserName : UITextField!;
    @IBOutlet weak var textPassword : UITextField!;
    
    var conn:NSURLConnection!;
    
    var data : NSData!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func login(){
        let url = Service.Instance.loginUrl();
        
        let request : NSMutableURLRequest = NSMutableURLRequest(URL: url);
        
        request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        request.HTTPMethod="POST";
        
        //let user = UserEntity(primaryId: textUserName.text!, password: textPassword.text!)

        //let postData : NSData! = user.parseEntityToJson().dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion:true);
            //
        let t = "{\"Name\":\"beibei\",\"Password\":\"123456\"}";
        
        let postData : NSData! = t.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion:true);
        request.HTTPBody = postData
        
        conn = NSURLConnection(request: request, delegate: self)
        
        conn.start()
    }
    
    
    func connection(didReceiveResponse: NSURLConnection!, didReceiveResponse response: NSURLResponse!) {
        print("didReceiveResponse")
        print(response);
        
    }
    
    func connection(connection: NSURLConnection!, didReceiveData conData: NSData!) {
        
        self.data = conData;
        //self.buffer.appendData(conData);
        
        
    }
    
    func connection(connection: NSURLConnection!, didFailWithError error: NSError!) {
        NSLog("%@", error.localizedDescription)
    }
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        // Continue the implementation to parse the
        // returned data
        connection.cancel();
        
        //var data : NSString! = NSString(data: self.buffer, encoding: NSUTF8StringEncoding);
        
        var dataDic = JSONHelper.Instance.parseJSONToDictionary(self.data)
        
        print(dataDic);
        self.performSegueWithIdentifier("loginSuccess", sender: nil)
    }
    

}

