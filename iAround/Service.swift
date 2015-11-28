//
//  Service.swift
//  iAround

//this is proxy class.
//
//  Created by ZhuBei on 21/11/15.
//  Copyright © 2015 Team3. All rights reserved.
//

import Foundation

public class Service{
    static let Instance : Service = Service();
    private let rootUrl : NSString = NSString(string : "http://52.32.120.191:8000/IEvent/EventsManager/reset/");
    private init(){}
    
    public func loginUrl() -> String{
        return ((rootUrl as String) + "Login1");
    }
    
    public func retriveEventsUrl() -> String{
        return ((rootUrl as String) + "RetriveEvents/%@/%@/%@")
    }
    
    public func addEventUrl() -> String{
        return ((rootUrl as String) + "AddEvent")
    }
}
